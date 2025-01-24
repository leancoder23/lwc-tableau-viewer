import { LightningElement,api } from 'lwc';
import {TableauViz,TableauEventType} from 'c/tableauEmbededLib';
import { reduceErrors } from './reduceError';
import getTableauToken from '@salesforce/apex/TableauViewerController.getTableauToken';

export default class TableauViewer extends LightningElement {
    
   @api src;
   @api height;
   @api width;
   @api hideToolbar;
   @api hideTab;
   @api device='default';

   initialRender = true;
   isInitializing=false;

   tableauUserToken;
   tableauVizInstance;
   errors = [];

    renderedCallback(){
        if(!this.initialRender) return;
        this.initialRender=false;
        this.initializeTableauViz();

   }

   get hasError(){
    return this.errors.length>0
   }

   get errorMessage(){
    return this.errors.join('\n');
   }

   @api renderReport(url){
        this.src=url;
        this.initializeTableauViz();
   }

   async initializeTableauViz(){
        if(!this.src) return;

        try{

            let viz;
            this.isInitializing=true;


            if(!this.tableauVizInstance){
                viz= new TableauViz();
                this.refs.tableauReportContainer.appendChild(viz);
                this.tableauVizInstance = viz;
            }   
            else{
              viz = this.tableauVizInstance;
            }
            
            this.tableauUserToken = await getTableauToken();
            viz.src = this.src;
            viz.height = this.height||800;
            if(this.width) viz.width=this.width;
            viz.hideToolbar = this.hideToolbar||false;
            viz.hideTabs=this.hideTab||false;
            viz.token=this.tableauUserToken;
            viz.device=this.device;
            

        }catch(err){
            this.errors.push(reduceErrors(err).join('\n'));
            console.log(reduceErrors(err).join('\n'),this.errors);
            console.log('Error retrieving tableau token', err);

        }finally{
            this.isInitializing=false;
        }
   }
}