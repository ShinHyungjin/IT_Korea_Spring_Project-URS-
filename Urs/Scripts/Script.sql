insert into store(store_id, store_name, store_location, store_phone, store_repimg, store_reservation, store_openhour, store_closehour, store_pass, category_id, store_account, store_image, store_info, member_id)  values(seq_store.nextval, '연안식당', '강남점', '02-1234-5678', 'kfbusiness.png', 'TRUE', '12:00', '23:00', 'FALSE', 1, '0222123-03-142', 'yeonan.png', '마싯는 꼬막비빔밥 파라요', 20, 2);

ALTER TABLE store DROP COLUMN store_tablecount;


DELETE FROM 