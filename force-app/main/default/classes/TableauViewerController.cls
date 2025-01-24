/**
 * Created by dsingh on 24.10.24.
 */

public with sharing class TableauViewerController {

    @AuraEnabled(Cacheable=false)
   public static String getTableauToken(){

      TableauViewerSettings__c settings =TableauViewerSettings__c.getInstance();
      if(settings.TableauUserNameField__c==null) {
          throw new AuraHandledException('TableauViewer Setting is not setup. Please contact administrator to setup the required settings');
      }

      String token = generateTableauJWT(settings.TableauClientId__c,
              settings.TableauClientSecretId__c,
              settings.TableauClientSecret__c,
              getTableauUsername());

       return token;
   }

   private static String getTableauUsername(){
       TableauViewerSettings__c settings =TableauViewerSettings__c.getInstance();
       String userId = UserInfo.getUserId();
       String soql = String.format('SELECT Id, {0} FROM User WHERE Id=:userId',
               new List<String>{settings.TableauUserNameField__c});

       SObject record = Database.query(soql).get(0);
       return (String)record.get(settings.TableauUserNameField__c);
   }


    private  static String generateTableauJWT(String clientId,String clientSecretId, String clientSecret, String userName){

        Map<String, String> header = new Map<String, String>{
                'alg' => 'HS256',
                'typ' => 'JWT',
                'kid'=>clientSecretId,
                'iss'=>clientId
        };


        //Token will be valid for 5 minutes
        Datetime now1 = Datetime.now();
        Long iat = (Long)(now1.getTime()/1000);
        Long exp = (Long)(now1.addMinutes(5).getTime()/1000);


        Map<String, Object> claim = new Map<String, Object>{
                'jti'=>UUID.randomUUID().toString(),
                'iss'=>clientId,
                'aud'=>'tableau',
                'sub' => userName,
                'scp'=>new List<String>{'tableau:views:embed','tableau:views:embed_authoring'},
                //'scp'=>new List<string>{'tableau:views:embed'},
                'iat'=>iat,
                'exp' => exp

        };
        String headerBase64 = EncodingUtil.base64Encode(Blob.valueOf(JSON.serialize(header)));
        String claimBase64 = EncodingUtil.base64Encode(Blob.valueOf(JSON.serialize(claim)));
        String salt = headerBase64 + '.' + claimBase64;
        Blob secretToken = Crypto.generateMac('HmacSHA256', Blob.valueOf(salt), Blob.valueOf(clientSecret));
        // Encode the binary HMAC output as Base64
        String signature = EncodingUtil.base64Encode(secretToken);
        // Combine components to form the JWT token
        String jwtToken = salt + '.' + signature;

        return jwtToken;
    }



}