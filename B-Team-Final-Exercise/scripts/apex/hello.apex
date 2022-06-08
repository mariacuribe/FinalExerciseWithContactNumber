// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

List<AggregateResult> res = [SELECT COUNT(Id) Conteo, AccountId  FROM Contact GROUP BY AccountId];
system.debug(res);

for(AggregateResult r:res){
    System.debug(r.get('Conteo'));
    System.debug(r.get('AccountId'));
}


