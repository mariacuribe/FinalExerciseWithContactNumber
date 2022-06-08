import { LightningElement, api } from 'lwc';
export default class ContactDetail extends LightningElement {
    @api contactId;

    handleSuccess() {
        eval("$A.get('e.force:refreshView').fire();");
        this.dispatchEvent(new CustomEvent('refreshevent'));
        console.log('Entré al handleSuccess');
    }

    handleCancel() {
        eval("$A.get('e.force:refreshView').fire();");
        console.log('Entré al handleCancel');
    }
}