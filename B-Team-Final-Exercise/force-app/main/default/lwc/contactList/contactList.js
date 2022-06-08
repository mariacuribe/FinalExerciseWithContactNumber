import { LightningElement, track, wire, api } from 'lwc';
import getContacts from "@salesforce/apex/Controller.getContacts";
import { refreshApex } from '@salesforce/apex';

export default class ContactList extends LightningElement {
	//Id de cuenta que recibe del componente padre accountList
	selectedAccountIdValue;
	contacts=[];

	@api get selectedAccountId(){
		return this.selectedAccountIdValue;
	};

	set selectedAccountId(value){
		this.selectedAccountIdValue = value;
		console.log('value', value);
		getContacts({clickAccountId: this.selectedAccountIdValue}).then((result) => {
			this.contacts = result;
			console.log('contactos 2',this.contacts);
		})
			.catch((error) => {
			console.error(error);
		})
	}

	connectedCallback(){
		getContacts({clickAccountId: this.selectedAccountIdValue}).then((result) => {
			this.contacts = result;
			console.log('contactos',this.contacts);
		})
			.catch((error) => {
			console.error(error);
		})
	}
    // //Metodo para traer contactos relacionados con la cuenta seleccionada
	// @wire (getContacts, {clickAccountId: '$selectedAccountIdValue'}) contacts;
	
	//Metodo para enviar al padre para que haga refresh de los contacts
	@api refresh(){
		console.log('Refresh de los contactos');
		//refreshApex(this.contacts);
	}
	
	//Evento para enviar selectedContactId al accountlist component y mostrarlo en el contactDetails
    @track selectedContactId = ' ';
	dispatchContact = ' ';
    handleSelect(event) {
        const selectedContactId = event.detail.name;
        this.selectedContactId = selectedContactId;
		console.log('Id de contacto enviado desde contactlist a accountlist '+this.selectedContactId);
		// Creates the event with the contact ID data.
		this.dispatchContact = this.selectedContactId;
        const selectedEvent = new CustomEvent('getcontactevent', { detail: this.dispatchContact });
        // Dispatches the event.
        this.dispatchEvent(selectedEvent);
    };
}