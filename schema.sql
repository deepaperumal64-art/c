CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL CHECK (role IN ('buyer', 'seller', 'admin')),
    date_of_birth DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock INTEGER NOT NULL DEFAULT 0,
    category VARCHAR(100),
    image_url TEXT,
    seller_id INTEGER REFERENCES users(id) ON DELETE SET NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS orders (
    id SERIAL PRIMARY KEY,
    buyer_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    total_amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(30) DEFAULT 'Pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS order_items (
    id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    product_id INTEGER NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    quantity INTEGER NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

INSERT INTO users (name, email, password, role)
VALUES ('Admin', 'admin@chocomart.com', 'admin123', 'admin')
ON CONFLICT (email) DO NOTHING;

INSERT INTO products (name, description, price, stock, category)
VALUES
('Dairy Milk', 'Classic milk chocolate', 50.00, 100, 'Chocolate'),
('KitKat', 'Crispy wafer chocolate', 40.00, 100, 'Chocolate'),
('Milky Bar', 'Smooth white chocolate', 30.00, 100, 'Chocolate'),
('5 Star', 'Caramel chocolate bar', 35.00, 100, 'Chocolate'),
('Munch', 'Crunchy wafer chocolate', 20.00, 100, 'Chocolate'),
('Perk', 'Wafer chocolate bar', 20.00, 100, 'Chocolate')
ON CONFLICT DO NOTHING;
INSERT INTO products (name, description, price, stock, category)
VALUES
('Dairy Milk', 'Classic smooth milk chocolate', 50.00, 100, 'Chocolate'),
('Dairy Milk Silk', 'Rich and creamy premium chocolate', 80.00, 100, 'Chocolate'),
('Dairy Milk Oreo', 'Milk chocolate with Oreo pieces', 90.00, 100, 'Chocolate'),
('KitKat', 'Crispy wafer covered with chocolate', 40.00, 100, 'Chocolate'),
('KitKat Chunky', 'Thick crispy wafer chocolate bar', 60.00, 100, 'Chocolate'),
('Milky Bar', 'Smooth and creamy white chocolate', 30.00, 100, 'White Chocolate'),
('5 Star', 'Chewy caramel chocolate bar', 35.00, 100, 'Chocolate'),
('5 Star 3D', 'Caramel filled chocolate bar', 40.00, 100, 'Chocolate'),
('Munch', 'Crunchy wafer chocolate', 20.00, 100, 'Wafer'),
('Perk', 'Light and crispy wafer chocolate', 20.00, 100, 'Wafer'),
('Perk Double', 'Double wafer chocolate bar', 30.00, 100, 'Wafer'),
('Nestle Classic', 'Classic creamy milk chocolate', 50.00, 100, 'Chocolate'),
('Bar One', 'Chocolate bar with caramel and nougat', 30.00, 100, 'Chocolate'),
('Temptations', 'Premium chocolate with rich filling', 60.00, 100, 'Premium'),
('Fuse', 'Chocolate with nuts and caramel', 40.00, 100, 'Chocolate'),
('Crispello', 'Light crispy chocolate fingers', 50.00, 100, 'Wafer'),
('Snickers', 'Chocolate with peanuts, caramel and nougat', 60.00, 100, 'Chocolate'),
('Mars', 'Chocolate with caramel and nougat', 70.00, 100, 'Chocolate'),
('Galaxy', 'Smooth and creamy milk chocolate', 100.00, 100, 'Premium'),
('Toblerone', 'Swiss chocolate with honey and almonds', 150.00, 100, 'Premium'),
('Ferrero Rocher', 'Premium hazelnut chocolate', 250.00, 50, 'Premium'),
('KitKat Dark', 'Dark chocolate crispy wafer', 70.00, 100, 'Dark Chocolate'),
('Lindt Excellence', 'Premium dark chocolate', 180.00, 50, 'Dark Chocolate'),
('Hersheys Kisses', 'Small creamy milk chocolate pieces', 120.00, 80, 'Premium'),
('Kinder Joy', 'Chocolate treat with surprise toy', 50.00, 100, 'Kids'),
('Kinder Bueno', 'Crispy wafer with creamy hazelnut filling', 100.00, 80, 'Premium'),
('Cadbury Bournville', 'Rich dark chocolate', 100.00, 80, 'Dark Chocolate'),
('Cadbury Gems', 'Colorful chocolate button candies', 30.00, 100, 'Kids'),
('Cadbury Fuse', 'Chocolate with nuts and caramel filling', 50.00, 100, 'Chocolate'),
('Choco Bar', 'Chocolate coated frozen dessert', 40.00, 100, 'Frozen Dessert');