from lxml import etree

# --- Đọc file XML ---
tree = etree.parse("banan.xml")
root = tree.getroot()

print("=== XPATH TRUY VẤN DỮ LIỆU QUẢN LÝ BÀN ĂN ===\n")

# 1. Lấy tất cả bàn
print("1. Tất cả bàn:")
for b in root.xpath("//BANS/BAN"):
    print(etree.tostring(b, pretty_print=True).decode())

# 2. Lấy tất cả nhân viên
print("\n2. Tất cả nhân viên:")
for nv in root.xpath("//NHANVIENS/NHANVIEN/TENV/text()"):
    print("-", nv)

# 3. Lấy tất cả tên món
print("\n3. Tên tất cả món:")
print(root.xpath("//MON/TENMON/text()"))

# 4. Tên nhân viên NV02
print("\n4. Tên NV02:", root.xpath("//NHANVIEN[MANV='NV02']/TENV/text()"))

# 5. Tên + SDT nhân viên NV03
print("\n5. Tên và SDT NV03:",
      root.xpath("//NHANVIEN[MANV='NV03']/TENV/text()"),
      root.xpath("//NHANVIEN[MANV='NV03']/SDT/text()"))

# 6. Món có giá > 50.000
print("\n6. Món giá > 50000:", root.xpath("//MON[number(GIA)>50000]/TENMON/text()"))

# 7. Số bàn của hóa đơn HD03
print("\n7. Số bàn HD03:", root.xpath("//HOADON[SOHD='HD03']/SOBAN/text()"))

# 8. Tên món có mã M02
print("\n8. Tên món M02:", root.xpath("//MON[MAMON='M02']/TENMON/text()"))

# 9. Ngày lập hóa đơn HD03
print("\n9. Ngày lập HD03:", root.xpath("//HOADON[SOHD='HD03']/NGAYLAP/text()"))

# 10. Tất cả mã món trong hóa đơn HD01
print("\n10. Mã món trong HD01:", root.xpath("//HOADON[SOHD='HD01']//MAMON/text()"))

# 11. Tên món trong hóa đơn HD01
print("\n11. Tên món trong HD01:",
      root.xpath("//MON[MAMON=//HOADON[SOHD='HD01']//MAMON]/TENMON/text()"))

# 12. Tên nhân viên lập hóa đơn HD02
print("\n12. Nhân viên lập HD02:",
      root.xpath("//NHANVIEN[MANV=//HOADON[SOHD='HD02']/MANV]/TENV/text()"))

# 13. Đếm số bàn
print("\n13. Tổng số bàn:", int(root.xpath("count(//BANS/BAN)")))

# 14. Đếm số hóa đơn NV01
print("\n14. Số hóa đơn NV01:", int(root.xpath("count(//HOADON[MANV='NV01'])")))

# 15. Tên món trong hóa đơn của bàn số 2
print("\n15. Món bàn 2:",
      root.xpath("//MON[MAMON=//HOADON[SOBAN='2']//MAMON]/TENMON/text()"))

# 16. Nhân viên từng lập hóa đơn cho bàn số 3
print("\n16. Nhân viên bàn 3:",
      root.xpath("//NHANVIEN[MANV=//HOADON[SOBAN='3']/MANV]/TENV/text()"))

# 17. Hóa đơn do nhân viên nữ lập
print("\n17. Hóa đơn nhân viên nữ lập:",
      root.xpath("//HOADON[MANV=//NHANVIEN[GIOITINH='Nữ']/MANV]/SOHD/text()"))

# 18. Nhân viên phục vụ bàn số 1
print("\n18. Nhân viên bàn 1:",
      root.xpath("//NHANVIEN[MANV=//HOADON[SOBAN='1']/MANV]/TENV/text()"))

# 19. Món gọi nhiều hơn 1 lần
print("\n19. Món gọi >1 lần:",
      root.xpath("//MON[MAMON=//CTHD[number(SOLUONG)>1]/MAMON]/TENMON/text()"))

# 20. Tên bàn + ngày lập hóa đơn HD02
print("\n20. Bàn + ngày lập HD02:",
      root.xpath("concat(//BAN[SOBAN=//HOADON[SOHD='HD02']/SOBAN]/TENBAN, ' - ', //HOADON[SOHD='HD02']/NGAYLAP)"))
