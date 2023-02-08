@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface CDS for Customer'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zpla_i_customer
  as select from zpla_b_customer as Customer
  
composition [1..*] of zpla_i_address as _Address 
  
{
  key CustomerId,
      CustomerFirstName,
      CustomerLastName,
      CustomerPhoneNumber,
      CustomerEmail,
      AddressId,
      @Semantics.systemDateTime.lastChangedAt: true
      LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      LocalLastChangedAt,
      
      _Address
}
