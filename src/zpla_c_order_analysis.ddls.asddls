@EndUserText.label: 'Consumption CDS for Order Analysis'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity zpla_c_order_analysis
  as projection on zpla_i_order_analysis
{
  key OrderUuid,
      OrderId,
      @Consumption.valueHelpDefinition: [{ entity : {name: 'zpla_i_customer' , element: 'CustomerId' } }]
      @EndUserText.label: 'Customer'
      @ObjectModel.text.element: ['FullName']
      @Search.defaultSearchElement: true
      @UI.textArrangement: #TEXT_ONLY
      CustomerId,
      FullName,
      OrderDate,
      @EndUserText.label: 'DeliveryDate'
      DeliveryDate,
      @Consumption.valueHelpDefinition: [{ entity : {name: 'zpla_b_delivery_type' , element: 'TypeId' } }]
      @EndUserText.label: 'Delivery'
      @ObjectModel.text.element: ['Delivery']
      @Search.defaultSearchElement: true
      @UI.textArrangement: #TEXT_ONLY
      DeliveryId,
      _Delivery.DeliveryName    as Delivery,
      @Consumption.valueHelpDefinition: [{ entity : {name: 'zpla_b_status' , element: 'StatusId' } }]
      @EndUserText.label: 'Status'
      @ObjectModel.text.element: ['Status']
      @Search.defaultSearchElement: true
      @UI.textArrangement: #TEXT_ONLY
      StatusId,
      _Status.StatusDescription as Status,
      StatusCriticality,
      @Semantics.amount.currencyCode: 'Currency'
      DeliveryCost,
      @Aggregation.default: #SUM
      @Semantics.amount.currencyCode: 'Currency'
      OrderTotalCost,
      Currency,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      LocalLastChangedAt,
      /* Associations */
      _Customer,
      _Delivery,
      _Status
}
