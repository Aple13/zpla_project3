@EndUserText.label: 'Consumption CDS for Customer'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@Search.searchable: true


define root view entity zpla_c_customer
  as projection on zpla_i_customer as Customer

{
      @Search.defaultSearchElement: true
  key CustomerId,
      CustomerFirstName,
      CustomerLastName,
      CustomerPhoneNumber,
      CustomerEmail,
      @Consumption.valueHelpDefinition: [{ entity : {name: 'zpla_b_address' , element: 'AddressId' } }]
      AddressId,
      LastChangedAt,
      LocalLastChangedAt,
      /* Associations */
      _Address : redirected to composition child zpla_c_address
}
