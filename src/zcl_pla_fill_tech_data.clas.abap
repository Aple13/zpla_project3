CLASS zcl_pla_fill_tech_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_pla_fill_tech_data IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA: it_category TYPE TABLE OF zpla_d_categoryt.
*    DATA: it_status TYPE TABLE OF zpla_d_status.
    DATA: it_item TYPE TABLE OF zpla_d_item.
    DATA: it_item_t TYPE TABLE OF zpla_d_item_t.
*    DATA: it_address TYPE TABLE OF zpla_d_address.
*    DATA: it_pickup TYPE TABLE OF zpla_d_pickup.
*    DATA: it_delivery_type TYPE TABLE OF zpla_d_deliv_typ.
*    DATA: it_delivery TYPE TABLE OF zpla_d_delivery.
*
*    DATA: it_customer TYPE TABLE OF zpla_d_customer.
*    DATA: it_order TYPE TABLE OF zpla_d_order.
*    DATA: it_orderitems TYPE TABLE OF zpla_d_orderitem.


    it_category = VALUE #(
        ( langu  = 'E' category_id = '1' item_category = 'Weapon' img_url = 'https://e7.pngegg.com/pngimages/469/448/png-clipart-arkham-horror-elder-sign-cthulhu-mythos-the-call-of-cthulhu-ink-star-miscellaneous-game-thumbnail.png' )
        ( langu  = 'E' category_id = '2' item_category = 'Tome' img_url = 'https://e7.pngegg.com/pngimages/469/448/png-clipart-arkham-horror-elder-sign-cthulhu-mythos-the-call-of-cthulhu-ink-star-miscellaneous-game-thumbnail.png' )
        ( langu  = 'E' category_id = '3' item_category = 'Magical' img_url = 'https://e7.pngegg.com/pngimages/469/448/png-clipart-arkham-horror-elder-sign-cthulhu-mythos-the-call-of-cthulhu-ink-star-miscellaneous-game-thumbnail.png')
        ( langu  = 'E' category_id = '4' item_category = 'Artifacts' img_url = 'https://e7.pngegg.com/pngimages/469/448/png-clipart-arkham-horror-elder-sign-cthulhu-mythos-the-call-of-cthulhu-ink-star-miscellaneous-game-thumbnail.png' )
**        ( langu  = 'R' category_id = '1' item_category = 'Ракетки' )
**        ( langu  = 'R' category_id = '2' item_category = 'Мячи' )
**        ( langu  = 'R' category_id = '3' item_category = 'Кроссовки' )
**        ( langu  = 'R' category_id = '4' item_category = 'Аксессуары' )
     ).
*
*    it_status = VALUE #(
*       ( langu  = 'E' status_id = '1' status_description = 'New' )
*       ( langu  = 'E' status_id = '2' status_description = 'In progress' )
*       ( langu  = 'E' status_id = '3' status_description = 'Completed' )
*       ( langu  = 'E' status_id = '4' status_description = 'Canceled' )
**       ( langu  = 'R' status_id = '1' status_description = 'Новый' )
**       ( langu  = 'R' status_id = '2' status_description = 'В реализации' )
**       ( langu  = 'R' status_id = '3' status_description = 'Выполнен' )
**       ( langu  = 'R' status_id = '4' status_description = 'Отменен' )
*    ).
*
    it_item = VALUE #(
       ( item_id  = '1' item_price = '154.40' currency = 'USD' item_qty = '19' )
       ( item_id  = '2' item_price = '270.90' currency = 'USD' item_qty = '14' )
       ( item_id  = '3' item_price = '89.90' currency = 'USD' item_qty = '10' )
       ( item_id  = '4' item_price = '173.40' currency = 'USD' item_qty = '11' )
       ( item_id  = '5' item_price = '64.40' currency = 'USD' item_qty = '8' )
       ( item_id  = '6' item_price = '322.40' currency = 'USD' item_qty = '7' )
       ( item_id  = '7' item_price = '386.40' currency = 'USD' item_qty = '8' )
       ( item_id  = '8' item_price = '244.40' currency = 'USD' item_qty = '12' )
       ( item_id  = '9' item_price = '83.40' currency = 'USD' item_qty = '6' )
       ( item_id  = '10' item_price = '222.40' currency = 'USD' item_qty = '9' )
       ( item_id  = '11' item_price = '45.90' currency = 'USD' item_qty = '13' )
       ( item_id  = '12' item_price = '76.40' currency = 'USD' item_qty = '15' )
       ( item_id  = '13' item_price = '85.90' currency = 'USD' item_qty = '7' )
       ( item_id  = '14' item_price = '82.90' currency = 'USD' item_qty = '12' )
       ( item_id  = '15' item_price = '69.90' currency = 'USD' item_qty = '14' )
       ( item_id  = '16' item_price = '55.40' currency = 'USD' item_qty = '15' )
       ( item_id  = '17' item_price = '74.40' currency = 'USD' item_qty = '13' )
       ( item_id  = '18' item_price = '114.90' currency = 'USD' item_qty = '15' )
       ( item_id  = '19' item_price = '206.40' currency = 'USD' item_qty = '10' )
       ( item_id  = '20' item_price = '36.90' currency = 'USD' item_qty = '15' )
       ( item_id  = '21' item_price = '544.40' currency = 'USD' item_qty = '6' )
       ( item_id  = '22' item_price = '521.90' currency = 'USD' item_qty = '12' )
       ( item_id  = '23' item_price = '564.40' currency = 'USD' item_qty = '7' )
       ( item_id  = '24' item_price = '561.90' currency = 'USD' item_qty = '5' )
       ( item_id  = '25' item_price = '584.40' currency = 'USD' item_qty = '8' )
       ( item_id  = '26' item_price = '1399.90' currency = 'USD' item_qty = '7' )
       ( item_id  = '27' item_price = '1417.40' currency = 'USD' item_qty = '13' )
       ( item_id  = '28' item_price = '1364.40' currency = 'USD' item_qty = '6' )
       ( item_id  = '29' item_price = '1221.90' currency = 'USD' item_qty = '12' )
       ( item_id  = '30' item_price = '1110.90' currency = 'USD' item_qty = '4' )
    ).
*
    it_item_t = VALUE #(
*       ( langu  = 'E' item_id = '1' category_id = '1' item_name = 'RACKET TECNIFIBRE TEMPO 298 IGA' item_description ='WEIGHT: 298, HEAD SIZE (CM2): 630, BALANCE: 320, STRING PATTERN: 16/19' )
*       ( langu  = 'E' item_id = '2' category_id = '1' item_name = 'RACKET WILSON CLASH 100 PRO V2.0' item_description ='WEIGHT: 310, HEAD SIZE (CM2): 645, BALANCE: 306, STRING PATTERN: 16/20' )
*       ( langu  = 'E' item_id = '3' category_id = '1' item_name = 'RACKET WILSON CLASH 98 V2.0' item_description ='WEIGHT: 310, HEAD SIZE (CM2): 632, BALANCE: 306, STRING PATTERN: 16/20' )
*       ( langu  = 'E' item_id = '4' category_id = '1' item_name = 'RACKET WILSON BLADE 98 (18X20) V8.0' item_description ='WEIGHT: 305, HEAD SIZE (CM2): 632, BALANCE: 320, STRING PATTERN: 18/20' )
*       ( langu  = 'E' item_id = '5' category_id = '1' item_name = 'RACKET WILSON PRO STAFF RF97 V13.0' item_description ='WEIGHT: 340, HEAD SIZE (CM2): 626, BALANCE: 305, STRING PATTERN: 16/19' )
*       ( langu  = 'E' item_id = '6' category_id = '1' item_name = 'RACKET HEAD SPEED MP 2022' item_description ='WEIGHT: 300, HEAD SIZE (CM2): 645, BALANCE: 320, STRING PATTERN: 16/19' )
*       ( langu  = 'E' item_id = '7' category_id = '1' item_name = 'RACKET HEAD SPEED TEAM 2022' item_description ='WEIGHT: 285, HEAD SIZE (CM2): 645, BALANCE: 320, STRING PATTERN: 16/19' )
*       ( langu  = 'E' item_id = '8' category_id = '1' item_name = 'RACKET HEAD GRAPHENE 360+ INSTINCT MP' item_description ='WEIGHT: 300, HEAD SIZE (CM2): 645, BALANCE: 320, STRING PATTERN: 16/19' )
*       ( langu  = 'E' item_id = '9' category_id = '1' item_name = 'RACKET HEAD BOOM PRO 2022' item_description ='WEIGHT: 310, HEAD SIZE (CM2): 630, BALANCE: 310, STRING PATTERN: 16/19' )
*       ( langu  = 'E' item_id = '10' category_id = '1' item_name = 'RACKET YONEX NEW EZONE 98' item_description ='WEIGHT: 305, HEAD SIZE (CM2): 630, BALANCE: 315, STRING PATTERN: 16/19' )
*       ( langu  = 'E' item_id = '11' category_id = '2' item_name = 'BALLS HEAD PRO 4B' item_description ='PACKING (NUMBER OF PIECES): 4, TYPE OF BALL: PRESSURIZED' )
*       ( langu  = 'E' item_id = '12' category_id = '2' item_name = 'BALLS WILSON TOUR PREMIER ALL COURT 4B' item_description ='PACKING (NUMBER OF PIECES): 4, TYPE OF BALL: PRESSURIZED' )
*       ( langu  = 'E' item_id = '13' category_id = '2' item_name = 'BALLS HEAD PRO - 18 X 4B' item_description ='PACKING (NUMBER OF PIECES): 72, TYPE OF BALL: PRESSURIZED' )
*       ( langu  = 'E' item_id = '14' category_id = '2' item_name = 'BALLS BABOLAT TEAM 3B' item_description ='PACKING (NUMBER OF PIECES): 3, TYPE OF BALL: PRESSURIZED, TECHNOLOGIES: EXTRA FEEL FELT' )
*       ( langu  = 'E' item_id = '15' category_id = '2' item_name = 'BALLS DUNLOP FORT CLAY COURT 4B' item_description ='PACKING (NUMBER OF PIECES): 4, TYPE OF BALL: PRESSURIZED' )
*       ( langu  = 'E' item_id = '16' category_id = '2' item_name = 'BALLS HEAD CHAMPIONSHIP 4B' item_description ='PACKING (NUMBER OF PIECES): 4, TYPE OF BALL: PRESSURIZED' )
*       ( langu  = 'E' item_id = '17' category_id = '2' item_name = 'BALLS PACIFIC PRO TOUR 4B' item_description ='PACKING (NUMBER OF PIECES): 4, TYPE OF BALL: PRESSURIZED' )
*       ( langu  = 'E' item_id = '18' category_id = '2' item_name = 'BALLS TECNIFIBRE CLUB BI-PACK 2 X 4B' item_description ='PACKING (NUMBER OF PIECES): 8, TYPE OF BALL: PRESSURIZED' )
*       ( langu  = 'E' item_id = '19' category_id = '2' item_name = 'BALLS TRETORN COACH BAG 72B' item_description ='PACKING (NUMBER OF PIECES): 72, TYPE OF BALL: NO PRESSURIZED' )
*       ( langu  = 'E' item_id = '20' category_id = '2' item_name = 'BALLS TRETORN SWEDISH OPEN 4B' item_description ='PACKING (NUMBER OF PIECES): 8, TYPE OF BALL: PRESSURIZED' )
*       ( langu  = 'E' item_id = '21' category_id = '3' item_name = 'K-SWISS HYPERCOURT SUPREME HB' item_description ='MENS, MAIN COLOR:  BLUE, SIZE:  41-47' )
*       ( langu  = 'E' item_id = '22' category_id = '3' item_name = 'K-SWISS HYPERCOURT EXPRESS 2 HB' item_description ='WOMENS, MAIN COLOR:  BLACK, SIZE:  37-41' )
*       ( langu  = 'E' item_id = '23' category_id = '3' item_name = 'ASICS GEL-DEDICATE 7 CLAY' item_description ='MENS, MAIN COLOR:  WHITE, SIZE:  41-47' )
*       ( langu  = 'E' item_id = '24' category_id = '3' item_name = 'LOTTO MIRAGE 600 ALR' item_description ='MENS, MAIN COLOR:  WHITE, SIZE:  41-47' )
*       ( langu  = 'E' item_id = '25' category_id = '3' item_name = 'WOMENS SHOESLOTTO MIRAGE 200 SPEED' item_description ='WOMENS, MAIN COLOR:  WHITE, SIZE:  37-41' )
*       ( langu  = 'E' item_id = '26' category_id = '4' item_name = 'BALL BASKET PRO BALLWAGEN 150' item_description ='BALL BASKET, CAPACITY OF BASKET: 150, HEIGHT OF BASKET: 85 CM' )
*       ( langu  = 'E' item_id = '27' category_id = '4' item_name = 'NIKE HYPERFUEL WATER BOTTLE 2.0 0,50 L' item_description ='WATER BOTTLE, CAPACITY: 0,5 L, MAIN COLOUR: BLACK' )
*       ( langu  = 'E' item_id = '28' category_id = '4' item_name = 'ZAMST KNEE SUPPORT RK-1 PLUS RIGHT' item_description ='STABILIZER, MAIN COLOUR: BLACK' )
*       ( langu  = 'E' item_id = '29' category_id = '4' item_name = 'YAKIMASPORT 60 MINI CONES SET' item_description ='CONES, PACKING (NUMBER OF PIECES): 60' )
*       ( langu  = 'E' item_id = '30' category_id = '4' item_name = 'DUNLOP NET + POST SET 6 M' item_description ='TENNIS NET, LENGH: 6 M' )
       ( langu  = 'E' item_id = '1' category_id = '1' item_name = '.38 Revolver' item_description ='Gain +2 Strength during Combat Encounters' )
       ( langu  = 'E' item_id = '2' category_id = '1' item_name = '.45 Automatic' item_description ='Gain +3 Strength during Combat Encounters' )
       ( langu  = 'E' item_id = '3' category_id = '1' item_name = '.18 Derringer' item_description ='Add 1 to the result of 1 die Strength test during a Combat Encounter' )
       ( langu  = 'E' item_id = '4' category_id = '1' item_name = 'Axe' item_description ='Gain +2 Strength during Combat Encounters. Spend 2 Sanity to reroll any number of dice' )
       ( langu  = 'E' item_id = '5' category_id = '1' item_name = 'Bull Whip' item_description ='Gain +1 Strength during Combat Encounters. You may reroll 1 die' )
       ( langu  = 'E' item_id = '6' category_id = '1' item_name = 'Double-barreled Shotgun' item_description ='Gain +4 Strength during Combat Encounters' )
       ( langu  = 'E' item_id = '7' category_id = '1' item_name = 'Flamethrower' item_description ='Gain +5 Strength during Combat Encounters. Reduce the damage of Monsters by 1 ' )
       ( langu  = 'E' item_id = '8' category_id = '1' item_name = 'Mauser C96' item_description ='Gain +2 Strength during Combat Encounters. You may reroll 1 die' )
       ( langu  = 'E' item_id = '9' category_id = '1' item_name = 'Tear Gas' item_description ='Reroll up to 2 dice during a Combat Encounter. Reduce the Monsters damage by 2' )
       ( langu  = 'E' item_id = '10' category_id = '1' item_name = 'Tommy Gun' item_description ='Gain +4 Strength during Combat Encounters' )
       ( langu  = 'E' item_id = '11' category_id = '2' item_name = 'Arcane Manuscripts' item_description ='Gain +1 Lore when resolving Spell effects' )
       ( langu  = 'E' item_id = '12' category_id = '2' item_name = 'Arcane Sutra' item_description ='Gain +2 Lore when resolving Spell effects. You may reroll 2 dice' )
       ( langu  = 'E' item_id = '13' category_id = '2' item_name = 'Arcane Tome' item_description ='Gain +2 Lore when resolving Spell effects. When you Rest action, gain 1 Spell' )
       ( langu  = 'E' item_id = '14' category_id = '2' item_name = 'Astronomy Guidebook' item_description ='When you close a Gate, recover 1 Sanity and gain 1 Clue' )
       ( langu  = 'E' item_id = '15' category_id = '2' item_name = 'Book of Spells' item_description ='When you gain this card, gain 1 Spell. Gain +2 Lore when resolving Spell effects.' )
       ( langu  = 'E' item_id = '16' category_id = '2' item_name = 'Dream Diary' item_description ='Gain +1 Lore during Other World Encounters. When you perform a Rest action, spawn 1 Clue' )
       ( langu  = 'E' item_id = '17' category_id = '2' item_name = 'Forbidden Secrets' item_description ='Gain +1 Will during Combat Encounters. If you do not lose Sanity, gain 1 Clue' )
       ( langu  = 'E' item_id = '18' category_id = '2' item_name = 'Grim Lexicon' item_description ='When you gain this card, gain 1 Clue. Reduce the horror of Monsters by 1 to a minimum of 1' )
       ( langu  = 'E' item_id = '19' category_id = '2' item_name = 'Grotesque Compendium' item_description ='Gain +4 Lore when resolving Spell effects. Each 6 you roll when resolving a Spell effect counts as two successes' )
       ( langu  = 'E' item_id = '20' category_id = '2' item_name = 'King James Bible' item_description ='You may reroll 1 die when resolving a Will test during a Combat Encounter. When you Rest, recover 1 additional Sanity' )
       ( langu  = 'E' item_id = '21' category_id = '3' item_name = 'Blessed Blade' item_description ='When you gain this card, gain 1 Boon Conditions. Gain +3 Strength during Combat Encounters' )
       ( langu  = 'E' item_id = '22' category_id = '3' item_name = 'Protective Totem' item_description ='Once per round, if you would lose 2 or more Health and/or Sanity, prevent 1 of that loss' )
       ( langu  = 'E' item_id = '23' category_id = '3' item_name = 'Spirit Dagger' item_description ='Gain +1 Will and +2 Strength during Combat Encounters' )
       ( langu  = 'E' item_id = '24' category_id = '3' item_name = 'Timeworn Brand' item_description ='Gain +1 Strength during Combat Encounters. You may reroll 1 die' )
       ( langu  = 'E' item_id = '25' category_id = '3' item_name = 'Vampiric Talisman' item_description ='Gain +2 Strength during Combat Encounters. When you defeat a Monster, gain 1 Focus' )
       ( langu  = 'E' item_id = '26' category_id = '4' item_name = 'Grotesque Statue' item_description ='Gain 5 Clues. Once per round, you may spend 1 Clue to prevent all Sanity loss from a single effect' )
       ( langu  = 'E' item_id = '27' category_id = '4' item_name = 'Necronomicon' item_description ='Action: Test Lore. If you pass, you may spend 1 Sanity to gain 2 Spells' )
       ( langu  = 'E' item_id = '28' category_id = '4' item_name = 'Ruby of Rlyeh' item_description ='Once per round you may spend 1 Sanity and perform 1 additional action' )
       ( langu  = 'E' item_id = '29' category_id = '4' item_name = 'Sword of Saint Jerome' item_description ='Gain +2 Will and +5 Strength when resolving Combat Encounters. If you defeat a Monster, recover 1 Sanity' )
       ( langu  = 'E' item_id = '30' category_id = '4' item_name = 'The Silver Key' item_description ='Once per round, you may spend 1 less Clue to pay for an effect. You may reroll 1 die' )
    ).
*
*    it_address = VALUE #(
*       ( address_id  = '1' postal_code = '1-123' city = 'ARKHAM' street = 'BROWN' building = '2' apartments = '' )
*       ( address_id  = '2' postal_code = '1-568' city = 'DUNWICH' street = 'LAKES' building = '5' apartments = '' )
*       ( address_id  = '3' postal_code = '1-418' city = 'INNSMOUTH' street = 'OAKTREES' building = '3' apartments = '' )
*       ( address_id  = '4' postal_code = '1-314' city = 'KINGSPORT' street = 'FESTIVAL' building = '19' apartments = '' )
*       ( address_id  = '11' customer_id = '1' postal_code = '1-545' city = 'ARKHAM' street = 'BBQ' building = '12' apartments = '22' )
*    ).
*
*
*    it_pickup = VALUE #(
*      ( pickup_id  = '1' address_id = '1' pickup_schedule = 'MON.-FR.: 09:00-21:00.' )
*      ( pickup_id  = '2' address_id = '2' pickup_schedule = 'MON.-FR.: 09:00-21:00.' )
*      ( pickup_id  = '3' address_id = '3' pickup_schedule = 'MON.-SAT.: 10:00-17:00.' )
*      ( pickup_id  = '4' address_id = '4' pickup_schedule = 'MON.-FR.: 10:00-17:00.' )
*    ).
*
*    it_delivery_type = VALUE #(
*       ( type_id  = '1' delivery_name = 'Courier' delivery_cost = '35' currency = 'USD' )
*       ( type_id  = '2' delivery_name = 'Pickup' delivery_cost = '0' currency = 'USD' )
*    ).
*
*    it_delivery = VALUE #(
*       ( delivery_id  = '1' type_id = '2' pickup_id = '1' courier_id = '' delivery_date = '' )
*       ( delivery_id  = '2' type_id = '2' pickup_id = '2' courier_id = '' delivery_date = '' )
*       ( delivery_id  = '3' type_id = '2' pickup_id = '3' courier_id = '' delivery_date = '' )
*       ( delivery_id  = '4' type_id = '2' pickup_id = '4' courier_id = '' delivery_date = '' )
*       ( delivery_id  = '5' type_id = '1' pickup_id = '' courier_id = '' delivery_date = '' )
*    ).
*
**    it_customer = VALUE #(
**       ( customer_id  = '1' customer_first_name = 'Norman' customer_last_name = 'Withers'
**         customer_phone_number = '123-456-789' customer_email  = 'norm@gmail.com' address_id = '11' )
**    ).
*
*
**    it_order = VALUE #(
**       ( order_uuid  = '1' order_id = '1' customer_id = '1' order_date = '20221129'
**         delivery_id  = '5' status_id = '1' order_total_cost = '443.80' currency = 'USD' )
**    ).

*    it_orderitems = VALUE #(
*       ( orderitem_uuid = '722D7AF658271EDD9BFA60719E701234' order_uuid  = '722D7AF658271EDD9BFA60719E704D6C' item_id = '28' cart_qty = '1' cart_subtotal = '64.40' currency = 'USD' )
*       ( orderitem_uuid = '722D7AF658271EDD9BFA60719E701234' order_uuid  = '722D7AF658271EDD9BFA60719E704D6C' item_id = '1' cart_qty = '1' cart_subtotal = '204.40' currency = 'USD' )
*       ( orderitem_uuid = 'E2B2DC47BB511EDD9DE22BA66BEE1324' order_uuid  = 'E2B2DC47BB511EDD9DE22BA66BEEC1E9' item_id = '0' cart_qty = '2' cart_subtotal = '1333.98' currency = 'USD' )
*    ).


    DELETE FROM zpla_d_categoryt.
    INSERT zpla_d_categoryt FROM TABLE @it_category.
*
*    DELETE FROM zpla_d_status.
*    INSERT zpla_d_status FROM TABLE @it_status.
*
    DELETE FROM zpla_d_item.
    INSERT zpla_d_item FROM TABLE @it_item.

    DELETE FROM zpla_d_item_t.
    INSERT zpla_d_item_t FROM TABLE @it_item_t.
*
*    DELETE FROM zpla_d_address.
*    INSERT zpla_d_address FROM TABLE @it_address.
*
*    DELETE FROM zpla_d_pickup.
*    INSERT zpla_d_pickup FROM TABLE @it_pickup.
*
*    DELETE FROM zpla_d_deliv_typ.
*    INSERT zpla_d_deliv_typ FROM TABLE @it_delivery_type.
*
*    DELETE FROM zpla_d_delivery.
*    INSERT zpla_d_delivery FROM TABLE @it_delivery.

*    DELETE FROM zpla_d_customer.
*    INSERT zpla_d_customer FROM TABLE @it_customer.

*    DELETE FROM zpla_d_order.
*    INSERT zpla_d_order FROM TABLE @it_order.

*    DELETE FROM zpla_d_orderitem.
*    INSERT zpla_d_orderitem FROM TABLE @it_orderitems.

    out->write( 'data was inserted successfully!' ).

  ENDMETHOD.
ENDCLASS.
