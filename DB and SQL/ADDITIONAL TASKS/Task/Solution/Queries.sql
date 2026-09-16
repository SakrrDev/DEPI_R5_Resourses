CREATE TABLE categories (
    id BIGSERIAL PRIMARY KEY,

    name VARCHAR(100) NOT NULL UNIQUE,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
    id BIGSERIAL PRIMARY KEY,

    name VARCHAR(150) NOT NULL,

    barcode VARCHAR(50) UNIQUE,

    category_id BIGINT NOT NULL,

    purchase_price NUMERIC(12, 2) NOT NULL DEFAULT 0,

    sale_price NUMERIC(12, 2) NOT NULL DEFAULT 0,

    min_stock NUMERIC(12, 3) NOT NULL DEFAULT 0,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_products_category
        FOREIGN KEY (category_id)
        REFERENCES categories(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT chk_products_purchase_price
        CHECK (purchase_price >= 0),

    CONSTRAINT chk_products_sale_price
        CHECK (sale_price >= 0),

    CONSTRAINT chk_products_min_stock
        CHECK (min_stock >= 0)
);

CREATE TABLE suppliers (
    id BIGSERIAL PRIMARY KEY,

    name VARCHAR(150) NOT NULL,

    phone VARCHAR(30),

    email VARCHAR(150),

    address TEXT,

    balance NUMERIC(12, 2) NOT NULL DEFAULT 0,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_suppliers_balance
        CHECK (balance >= 0)
);

CREATE TABLE customers (
    id BIGSERIAL PRIMARY KEY,

    name VARCHAR(150) NOT NULL,

    phone VARCHAR(30),

    email VARCHAR(150),

    address TEXT,

    balance NUMERIC(12, 2) NOT NULL DEFAULT 0,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_customers_balance
        CHECK (balance >= 0)
);

CREATE TABLE purchase_invoices (
    id BIGSERIAL PRIMARY KEY,

    invoice_number VARCHAR(50) NOT NULL UNIQUE,

    supplier_id BIGINT NOT NULL,

    invoice_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    total_amount NUMERIC(12, 2) NOT NULL DEFAULT 0,

    discount NUMERIC(12, 2) NOT NULL DEFAULT 0,

    paid_amount NUMERIC(12, 2) NOT NULL DEFAULT 0,

    remaining_amount NUMERIC(12, 2) NOT NULL DEFAULT 0,

    notes TEXT,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_purchase_invoices_supplier
        FOREIGN KEY (supplier_id)
        REFERENCES suppliers(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT chk_purchase_total
        CHECK (total_amount >= 0),

    CONSTRAINT chk_purchase_discount
        CHECK (discount >= 0),

    CONSTRAINT chk_purchase_paid
        CHECK (paid_amount >= 0),

    CONSTRAINT chk_purchase_remaining
        CHECK (remaining_amount >= 0)
);

CREATE TABLE purchase_items (
    id BIGSERIAL PRIMARY KEY,

    purchase_invoice_id BIGINT NOT NULL,

    product_id BIGINT NOT NULL,

    quantity NUMERIC(12, 3) NOT NULL,

    purchase_price NUMERIC(12, 2) NOT NULL,

    discount NUMERIC(12, 2) NOT NULL DEFAULT 0,

    total NUMERIC(12, 2) NOT NULL,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_purchase_items_invoice
        FOREIGN KEY (purchase_invoice_id)
        REFERENCES purchase_invoices(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_purchase_items_product
        FOREIGN KEY (product_id)
        REFERENCES products(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT chk_purchase_item_quantity
        CHECK (quantity > 0),

    CONSTRAINT chk_purchase_item_price
        CHECK (purchase_price >= 0),

    CONSTRAINT chk_purchase_item_discount
        CHECK (discount >= 0),

    CONSTRAINT chk_purchase_item_total
        CHECK (total >= 0)
);

CREATE TABLE sales_invoices (
    id BIGSERIAL PRIMARY KEY,

    invoice_number VARCHAR(50) NOT NULL UNIQUE,

    customer_id BIGINT,

    invoice_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    total_amount NUMERIC(12, 2) NOT NULL DEFAULT 0,

    discount NUMERIC(12, 2) NOT NULL DEFAULT 0,

    paid_amount NUMERIC(12, 2) NOT NULL DEFAULT 0,

    remaining_amount NUMERIC(12, 2) NOT NULL DEFAULT 0,

    notes TEXT,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_sales_invoices_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT chk_sales_total
        CHECK (total_amount >= 0),

    CONSTRAINT chk_sales_discount
        CHECK (discount >= 0),

    CONSTRAINT chk_sales_paid
        CHECK (paid_amount >= 0),

    CONSTRAINT chk_sales_remaining
        CHECK (remaining_amount >= 0)
);

CREATE TABLE sale_items (
    id BIGSERIAL PRIMARY KEY,

    sales_invoice_id BIGINT NOT NULL,

    product_id BIGINT NOT NULL,

    quantity NUMERIC(12, 3) NOT NULL,

    sale_price NUMERIC(12, 2) NOT NULL,

    discount NUMERIC(12, 2) NOT NULL DEFAULT 0,

    total NUMERIC(12, 2) NOT NULL,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_sale_items_invoice
        FOREIGN KEY (sales_invoice_id)
        REFERENCES sales_invoices(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_sale_items_product
        FOREIGN KEY (product_id)
        REFERENCES products(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT chk_sale_item_quantity
        CHECK (quantity > 0),

    CONSTRAINT chk_sale_item_price
        CHECK (sale_price >= 0),

    CONSTRAINT chk_sale_item_discount
        CHECK (discount >= 0),

    CONSTRAINT chk_sale_item_total
        CHECK (total >= 0)
);

CREATE INDEX idx_products_category_id
    ON products(category_id);

CREATE INDEX idx_products_barcode
    ON products(barcode);

CREATE INDEX idx_purchase_invoices_supplier_id
    ON purchase_invoices(supplier_id);

CREATE INDEX idx_purchase_invoices_date
    ON purchase_invoices(invoice_date);

CREATE INDEX idx_purchase_items_invoice_id
    ON purchase_items(purchase_invoice_id);

CREATE INDEX idx_purchase_items_product_id
    ON purchase_items(product_id);

CREATE INDEX idx_sales_invoices_customer_id
    ON sales_invoices(customer_id);

CREATE INDEX idx_sales_invoices_date
    ON sales_invoices(invoice_date);

CREATE INDEX idx_sale_items_invoice_id
    ON sale_items(sales_invoice_id);

CREATE INDEX idx_sale_items_product_id
    ON sale_items(product_id);

CREATE TABLE units (
    id BIGSERIAL PRIMARY KEY,

    name VARCHAR(50) NOT NULL UNIQUE,

    abbreviation VARCHAR(20) UNIQUE,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE payment_methods (
    id BIGSERIAL PRIMARY KEY,

    name VARCHAR(50) NOT NULL UNIQUE,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE stock_movements (
    id BIGSERIAL PRIMARY KEY,

    product_id BIGINT NOT NULL,

    movement_type VARCHAR(30) NOT NULL,

    quantity NUMERIC(12, 3) NOT NULL,

    reference_type VARCHAR(30),

    reference_id BIGINT,

    movement_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    notes TEXT,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_stock_movements_product
        FOREIGN KEY (product_id)
        REFERENCES products(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT chk_stock_movements_quantity
        CHECK (quantity <> 0),

    CONSTRAINT chk_stock_movements_type
        CHECK (
            movement_type IN (
                'PURCHASE',
                'SALE',
                'PURCHASE_RETURN',
                'SALE_RETURN',
                'ADJUSTMENT',
                'DAMAGE'
            )
        )
);

CREATE TABLE payments (
    id BIGSERIAL PRIMARY KEY,

    payment_type VARCHAR(20) NOT NULL,

    purchase_invoice_id BIGINT,

    sales_invoice_id BIGINT,

    payment_method_id BIGINT NOT NULL,

    amount NUMERIC(12, 2) NOT NULL,

    payment_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    notes TEXT,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_payments_payment_method
        FOREIGN KEY (payment_method_id)
        REFERENCES payment_methods(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_payments_purchase_invoice
        FOREIGN KEY (purchase_invoice_id)
        REFERENCES purchase_invoices(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_payments_sales_invoice
        FOREIGN KEY (sales_invoice_id)
        REFERENCES sales_invoices(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT chk_payments_amount
        CHECK (amount > 0),

    CONSTRAINT chk_payments_invoice_type
        CHECK (
            (purchase_invoice_id IS NOT NULL AND sales_invoice_id IS NULL)
            OR
            (purchase_invoice_id IS NULL AND sales_invoice_id IS NOT NULL)
        ),

    CONSTRAINT chk_payments_type
        CHECK (
            (payment_type = 'PURCHASE'
                AND purchase_invoice_id IS NOT NULL
                AND sales_invoice_id IS NULL)
            OR
            (payment_type = 'SALE'
                AND sales_invoice_id IS NOT NULL
                AND purchase_invoice_id IS NULL)
        )
);

CREATE TABLE roles (
    id BIGSERIAL PRIMARY KEY,

    name VARCHAR(50) NOT NULL UNIQUE,

    description TEXT,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,

    full_name VARCHAR(150) NOT NULL,

    username VARCHAR(100) NOT NULL UNIQUE,

    password_hash TEXT NOT NULL,

    role_id BIGINT NOT NULL,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    last_login TIMESTAMP,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_users_role
        FOREIGN KEY (role_id)
        REFERENCES roles(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE expenses (
    id BIGSERIAL PRIMARY KEY,

    title VARCHAR(150) NOT NULL,

    description TEXT,

    amount NUMERIC(12, 2) NOT NULL,

    expense_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    payment_method_id BIGINT,

    created_by BIGINT,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_expenses_payment_method
        FOREIGN KEY (payment_method_id)
        REFERENCES payment_methods(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_expenses_user
        FOREIGN KEY (created_by)
        REFERENCES users(id)
        ON UPDATE CASCADE
        ON DELETE SET NULL,

    CONSTRAINT chk_expenses_amount
        CHECK (amount > 0)
);

CREATE INDEX idx_stock_movements_product_id
    ON stock_movements(product_id);

CREATE INDEX idx_stock_movements_date
    ON stock_movements(movement_date);

CREATE INDEX idx_stock_movements_type
    ON stock_movements(movement_type);

CREATE INDEX idx_payments_purchase_invoice_id
    ON payments(purchase_invoice_id);

CREATE INDEX idx_payments_sales_invoice_id
    ON payments(sales_invoice_id);

CREATE INDEX idx_payments_payment_method_id
    ON payments(payment_method_id);

CREATE INDEX idx_payments_date
    ON payments(payment_date);

CREATE INDEX idx_users_role_id
    ON users(role_id);

CREATE INDEX idx_expenses_payment_method_id
    ON expenses(payment_method_id);

CREATE INDEX idx_expenses_created_by
    ON expenses(created_by);

CREATE INDEX idx_expenses_date
    ON expenses(expense_date);

INSERT INTO categories (id, name)
VALUES
    (1, 'Drinks'),
    (2, 'Dairy'),
    (3, 'Grocery'),
    (4, 'Snacks'),
    (5, 'Cleaning'),
    (6, 'Personal Care'),
    (7, 'Frozen Food'),
    (8, 'Canned Food');


INSERT INTO suppliers
    (id, name, phone, email, address, balance)
VALUES
    (1, 'Al Nile Food Distribution', '01010000001', 'sales@alnilefood.com', 'Cairo', 0),
    (2, 'Egyptian Beverages Company', '01010000002', 'info@egybeverages.com', 'Giza', 0),
    (3, 'Delta Grocery Supplier', '01010000003', 'delta@grocery.com', 'Zagazig', 0),
    (4, 'Fresh Dairy Company', '01010000004', 'sales@freshdairy.com', 'Mansoura', 0),
    (5, 'Clean Home Distribution', '01010000005', 'info@cleanhome.com', 'Cairo', 0);


INSERT INTO customers
    (id, name, phone, email, address, balance)
VALUES
    (1, 'Ahmed Mohamed', '01120000001', 'ahmed@example.com', 'Zagazig', 0),
    (2, 'Mohamed Ali', '01120000002', 'mohamed@example.com', 'Zagazig', 0),
    (3, 'Mahmoud Hassan', '01120000003', 'mahmoud@example.com', 'Cairo', 0),
    (4, 'Omar Ibrahim', '01120000004', 'omar@example.com', 'Belbeis', 0),
    (5, 'Mostafa Ahmed', '01120000005', 'mostafa@example.com', 'Abu Hammad', 0),
    (6, 'Sara Mohamed', '01120000006', 'sara@example.com', 'Zagazig', 0);


INSERT INTO products
    (
        id,
        name,
        barcode,
        category_id,
        purchase_price,
        sale_price,
        min_stock
    )
VALUES
    (1, 'Pepsi 330ml', '622100000001', 1, 10.00, 15.00, 20),
    (2, 'Coca Cola 330ml', '622100000002', 1, 10.00, 15.00, 20),
    (3, 'Mirinda Orange 330ml', '622100000003', 1, 9.00, 14.00, 15),
    (4, 'Mineral Water 1.5L', '622100000004', 1, 5.00, 8.00, 30),
    (5, 'Juice Mango 1L', '622100000005', 1, 22.00, 30.00, 10),
    (6, 'Full Cream Milk 1L', '622100000006', 2, 25.00, 32.00, 15),
    (7, 'Yogurt Plain 105g', '622100000007', 2, 6.00, 9.00, 30),
    (8, 'White Cheese 500g', '622100000008', 2, 35.00, 45.00, 10),
    (9, 'Chocolate Milk 200ml', '622100000009', 2, 10.00, 14.00, 15),
    (10, 'Rice 1kg', '622100000010', 3, 30.00, 38.00, 20),
    (11, 'Sugar 1kg', '622100000011', 3, 25.00, 30.00, 20),
    (12, 'Flour 1kg', '622100000012', 3, 22.00, 28.00, 15),
    (13, 'Cooking Oil 1L', '622100000013', 3, 55.00, 65.00, 15),
    (14, 'Pasta 400g', '622100000014', 3, 10.00, 14.00, 30),
    (15, 'Potato Chips 50g', '622100000015', 4, 7.00, 10.00, 30),
    (16, 'Chocolate Bar 50g', '622100000016', 4, 12.00, 18.00, 20),
    (17, 'Biscuits 100g', '622100000017', 4, 8.00, 12.00, 25),
    (18, 'Corn Snacks 50g', '622100000018', 4, 6.00, 9.00, 20),
    (19, 'Dishwashing Liquid 500ml', '622100000019', 5, 20.00, 28.00, 10),
    (20, 'Laundry Detergent 1kg', '622100000020', 5, 45.00, 55.00, 10),
    (21, 'Floor Cleaner 1L', '622100000021', 5, 30.00, 40.00, 10),
    (22, 'Shampoo 400ml', '622100000022', 6, 50.00, 65.00, 10),
    (23, 'Bath Soap 125g', '622100000023', 6, 10.00, 15.00, 20),
    (24, 'Toothpaste 100ml', '622100000024', 6, 25.00, 35.00, 15),
    (25, 'Frozen Peas 400g', '622100000025', 7, 25.00, 35.00, 10),
    (26, 'Frozen Mixed Vegetables 400g', '622100000026', 7, 28.00, 38.00, 10),
    (27, 'Frozen French Fries 1kg', '622100000027', 7, 45.00, 60.00, 10),
    (28, 'Tuna Can 140g', '622100000028', 8, 35.00, 45.00, 10),
    (29, 'Tomato Paste 400g', '622100000029', 8, 15.00, 22.00, 15),
    (30, 'Canned Beans 400g', '622100000030', 8, 18.00, 25.00, 15);


INSERT INTO purchase_invoices
    (
        id,
        invoice_number,
        supplier_id,
        invoice_date,
        total_amount,
        discount,
        paid_amount,
        remaining_amount,
        notes
    )
VALUES
    (1, 'PUR-1001', 1, '2026-09-01 09:30:00', 2250.00, 50.00, 1500.00, 700.00, 'First grocery stock purchase'),
    (2, 'PUR-1002', 2, '2026-09-03 10:15:00', 1800.00, 0.00, 1800.00, 0.00, 'Drinks purchase'),
    (3, 'PUR-1003', 3, '2026-09-05 11:00:00', 1500.00, 100.00, 1000.00, 400.00, 'Grocery products'),
    (4, 'PUR-1004', 4, '2026-09-07 08:45:00', 1200.00, 0.00, 1200.00, 0.00, 'Dairy products'),
    (5, 'PUR-1005', 5, '2026-09-09 12:30:00', 2100.00, 100.00, 2000.00, 0.00, 'Cleaning products');


INSERT INTO purchase_items
    (
        id,
        purchase_invoice_id,
        product_id,
        quantity,
        purchase_price,
        discount,
        total
    )
VALUES
    (1, 1, 10, 30, 30.00, 0.00, 900.00),
    (2, 1, 11, 30, 25.00, 0.00, 750.00),
    (3, 1, 14, 60, 10.00, 0.00, 600.00),
    (4, 2, 1, 50, 10.00, 0.00, 500.00),
    (5, 2, 2, 50, 10.00, 0.00, 500.00),
    (6, 2, 3, 50, 9.00, 0.00, 450.00),
    (7, 2, 4, 70, 5.00, 0.00, 350.00),
    (8, 3, 12, 30, 22.00, 0.00, 660.00),
    (9, 3, 13, 20, 55.00, 50.00, 1050.00),
    (10, 3, 15, 30, 7.00, 0.00, 210.00),
    (11, 4, 6, 30, 25.00, 0.00, 750.00),
    (12, 4, 7, 50, 6.00, 0.00, 300.00),
    (13, 4, 9, 15, 10.00, 0.00, 150.00),
    (14, 5, 19, 30, 20.00, 0.00, 600.00),
    (15, 5, 20, 25, 45.00, 50.00, 1075.00),
    (16, 5, 21, 15, 30.00, 0.00, 450.00);


INSERT INTO sales_invoices
    (
        id,
        invoice_number,
        customer_id,
        invoice_date,
        total_amount,
        discount,
        paid_amount,
        remaining_amount,
        notes
    )
VALUES
    (1, 'SAL-1001', 1, '2026-09-10 10:15:00', 130.00, 0.00, 130.00, 0.00, 'Regular customer sale'),
    (2, 'SAL-1002', NULL, '2026-09-10 11:30:00', 95.00, 5.00, 90.00, 0.00, 'Cash sale'),
    (3, 'SAL-1003', 2, '2026-09-11 12:10:00', 220.00, 20.00, 150.00, 50.00, 'Credit sale'),
    (4, 'SAL-1004', NULL, '2026-09-11 15:20:00', 180.00, 0.00, 180.00, 0.00, 'Cash sale'),
    (5, 'SAL-1005', 3, '2026-09-12 09:45:00', 310.00, 10.00, 300.00, 0.00, 'Regular customer sale'),
    (6, 'SAL-1006', 4, '2026-09-12 13:30:00', 275.00, 0.00, 275.00, 0.00, 'Regular customer sale'),
    (7, 'SAL-1007', NULL, '2026-09-13 17:10:00', 145.00, 0.00, 145.00, 0.00, 'Cash sale'),
    (8, 'SAL-1008', 5, '2026-09-14 10:00:00', 390.00, 15.00, 375.00, 0.00, 'Regular customer sale'),
    (9, 'SAL-1009', 6, '2026-09-14 11:45:00', 210.00, 10.00, 200.00, 0.00, 'Regular customer sale'),
    (10, 'SAL-1010', NULL, '2026-09-14 12:30:00', 165.00, 0.00, 165.00, 0.00, 'Cash sale');


INSERT INTO sale_items
    (
        id,
        sales_invoice_id,
        product_id,
        quantity,
        sale_price,
        discount,
        total
    )
VALUES
    (1, 1, 1, 3, 15.00, 0.00, 45.00),
    (2, 1, 15, 5, 10.00, 0.00, 50.00),
    (3, 1, 17, 2, 12.00, 0.00, 24.00),
    (4, 1, 23, 1, 15.00, 0.00, 15.00),

    (5, 2, 4, 5, 8.00, 0.00, 40.00),
    (6, 2, 15, 3, 10.00, 5.00, 25.00),
    (7, 2, 14, 2, 14.00, 0.00, 28.00),

    (8, 3, 6, 3, 32.00, 0.00, 96.00),
    (9, 3, 10, 2, 38.00, 0.00, 76.00),
    (10, 3, 13, 1, 65.00, 0.00, 65.00),

    (11, 4, 2, 4, 15.00, 0.00, 60.00),
    (12, 4, 4, 5, 8.00, 0.00, 40.00),
    (13, 4, 16, 3, 18.00, 0.00, 54.00),
    (14, 4, 18, 3, 9.00, 0.00, 27.00),

    (15, 5, 20, 2, 55.00, 0.00, 110.00),
    (16, 5, 21, 2, 40.00, 0.00, 80.00),
    (17, 5, 22, 1, 65.00, 0.00, 65.00),
    (18, 5, 24, 1, 35.00, 0.00, 35.00),

    (19, 6, 25, 2, 35.00, 0.00, 70.00), 
    (20, 6, 26, 2, 38.00, 0.00, 76.00),
    (21, 6, 27, 1, 60.00, 0.00, 60.00),
    (22, 6, 28, 1, 45.00, 0.00, 45.00),

    (23, 7, 3, 3, 14.00, 0.00, 42.00),
    (24, 7, 4, 5, 8.00, 0.00, 40.00),
    (25, 7, 15, 4, 10.00, 0.00, 40.00),
    (26, 7, 17, 2, 12.00, 0.00, 24.00),

    (27, 8, 10, 3, 38.00, 0.00, 114.00),
    (28, 8, 11, 3, 30.00, 0.00, 90.00),
    (29, 8, 13, 1, 65.00, 0.00, 65.00),
    (30, 8, 19, 2, 28.00, 0.00, 56.00),

    (31, 9, 7, 5, 9.00, 0.00, 45.00),
    (32, 9, 8, 2, 45.00, 0.00, 90.00),
    (33, 9, 16, 2, 18.00, 0.00, 36.00),
    (34, 9, 23, 2, 15.00, 0.00, 30.00),

    (35, 10, 1, 2, 15.00, 0.00, 30.00),
    (36, 10, 6, 2, 32.00, 0.00, 64.00),
    (37, 10, 14, 3, 14.00, 0.00, 42.00),
    (38, 10, 29, 1, 22.00, 0.00, 22.00);







