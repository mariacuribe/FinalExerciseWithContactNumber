import { LightningElement, api, wire, track } from 'lwc';
import getAccounts from "@salesforce/apex/Controller.getAccounts";
import { refreshApex } from '@salesforce/apex';
import getContactsNumber from '@salesforce/apex/Controller.getContactsNumber';
export default class AccountList extends LightningElement {
	//Llamando las cuentas con el wire
	//@wire (getAccounts) accounts

	@track accounts = [];
	contactNumber=[];
	@wire (getAccounts) wiredAccounts ({error, data}) {
		if (data) {
			let accounts=[];
			for (const account of data) {
				const accountRecord = Object.assign({},account);
				accounts.push(accountRecord);
			}
			getContactsNumber()
				.then((result) => {
				console.log('conteo ',result);
				for (let account of accounts) {
					for (const ar of result) {
						if(account.Id==ar.AccountId){
							account['Conteo'] = ar.Conteo;
						}
					}
				}

				this.contactNumber = result;
			})
				.catch((error) => {
				console.error(error);
			}).finally(()=>{
				this.accounts = [...accounts];
			});
		} else if (error) {
			console.log(error);
		}
	}


    //Metodo para manejar el evento de click sobre una cuenta
	@track selectedAccountId = ' ';
    handleSelect(event) {
        const selectedAccountId = event.detail.name;
        this.selectedAccountId = selectedAccountId;
		console.log('Cuenta seleccionada con click: '+this.selectedAccountId);
    };
	
	//Evento para traer el contactId desde contact list cuando se hace click a un contacto y mostrar el contact detail 
	@track selectedContactId = ' ';
	contactIdEvent(event) {
		console.log('Id de contacto recibido desde contactlist ' +event.detail);
        this.selectedContactId = event.detail;
    };

	//Metodo para actualizar cuentas cada que un contacto se cambia de cuenta desde el detail
	finalRefreshEvent() { 
		console.log('evento de refresh');
		refreshApex(this.accounts);
		//this.template.querySelector("c-contact-list").refresh();
		const selectedAccountId = this.selectedAccountId;
		this.selectedAccountId = null;
		this.selectedAccountId = selectedAccountId;
	};
}