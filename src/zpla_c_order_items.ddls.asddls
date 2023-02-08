@EndUserText.label: 'Consumption CDS for Order Items'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
@Metadata.allowExtensions: true

define view entity zpla_c_order_items
  as projection on zpla_i_order_items as OrderItems
{
  key OrderitemUuid,
      OrderUuid,
      @Consumption.valueHelpDefinition: [{ entity : {name: 'zpla_i_item' , element: 'ItemId' } }]
      @EndUserText.label: 'Product name'
      @ObjectModel.text.element: ['Item']
      @Search.defaultSearchElement: true
      ItemId,
      _Item.ItemName as Item,
      CartQty,
      CartSubtotal,
      Currency,
      CreatedBy,
      LastChangedBy,
      LocalLastChangedAt,
      /* Associations */
      _Item,
      _Order : redirected to parent zpla_c_order
}
