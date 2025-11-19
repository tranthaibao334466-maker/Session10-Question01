CREATE TABLE products(
	id SERIAL PRIMARY KEY,
	name VARCHAR(50),
	price NUMERIC(10,2),
	last_modified TIMESTAMP
); 

INSERT INTO products (name, price, last_modified)
VALUES
('Laptop Gaming X1', 25000000.00, '2025-11-18 09:00:00.000000'),
('Dien thoai di dong Z', 15500000.50, '2025-11-17 14:30:15.123456'),
('May tinh bang Pro', 9800000.00, '2025-11-16 23:59:59'),
('Tai nghe khong day S', 3200000.00, '2025-11-15 08:00:00.000'),
('Chuot quang RGB', 550000.99, '2025-11-14 12:00:00');


CREATE OR REPLACE FUNCTION update_last_modified()
RETURNS TRIGGER
LANGUAGE plpgsql AS
$$
	BEGIN
		NEW.last_modified = NOW();
		RAISE NOTICE 'The product with ID % was updated', NEW.id;
		RETURN NEW; 
	END;
$$;

CREATE OR REPLACE TRIGGER trg_update_last_modified
BEFORE UPDATE ON products 
FOR EACH ROW 
EXECUTE FUNCTION update_last_modified(); 

SELECT * FROM products;
UPDATE products 
SET price = 7000000
WHERE id = 2; 
