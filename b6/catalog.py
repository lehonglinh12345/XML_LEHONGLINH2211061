from lxml import etree
import mysql.connector

# --- Parse XML và XSD ---
xml_file = "catalog.xml"
xsd_file = "catalog.xsd"

xml_doc = etree.parse(xml_file)
xsd_doc = etree.parse(xsd_file)
xsd_schema = etree.XMLSchema(xsd_doc)

# --- Validate XML ---
if xsd_schema.validate(xml_doc):
    print(" XML hợp lệ với XSD")
else:
    print(" XML không hợp lệ")
    print(xsd_schema.error_log)
    exit()

# --- Kết nối MySQL ---
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="shopdb"
)
cursor = conn.cursor()

# --- Tạo bảng (nếu chưa có) ---
cursor.execute("""
CREATE TABLE IF NOT EXISTS categories (
    id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(255)
)
""")

cursor.execute("""
CREATE TABLE IF NOT EXISTS products (
    id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(255),
    price DECIMAL(10,2),
    currency VARCHAR(10),
    stock INT,
    categoryRef VARCHAR(10),
    FOREIGN KEY (categoryRef) REFERENCES categories(id)
)
""")

# --- Dùng XPath để lấy dữ liệu ---
categories = xml_doc.xpath("//category")
products = xml_doc.xpath("//product")

# --- Thêm dữ liệu vào bảng categories ---
for c in categories:
    cat_id = c.get("id")
    cat_name = c.text
    cursor.execute("INSERT IGNORE INTO categories (id, name) VALUES (%s, %s)", (cat_id, cat_name))

# --- Thêm dữ liệu vào bảng products ---
for p in products:
    pid = p.get("id")
    category_ref = p.get("categoryRef")
    name = p.findtext("name")
    price = float(p.findtext("price"))
    currency = p.find("price").get("currency")
    stock = int(p.findtext("stock"))

    cursor.execute("""
        INSERT INTO products (id, name, price, currency, stock, categoryRef)
        VALUES (%s, %s, %s, %s, %s, %s)
        ON DUPLICATE KEY UPDATE
            name=VALUES(name),
            price=VALUES(price),
            currency=VALUES(currency),
            stock=VALUES(stock),
            categoryRef=VALUES(categoryRef)
    """, (pid, name, price, currency, stock, category_ref))

conn.commit()
print(" Dữ liệu đã được thêm vào MySQL thành công!")

cursor.close()
conn.close()
