<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <meta charset="UTF-8"/>
                <title>Kết quả truy vấn Quản lý bàn ăn</title>
                <style>
                    body {
                    font-family: Arial, sans-serif;
                    margin: 30px;
                    }
                    h1, h2 {
                    text-align: center;
                    }
                    table {
                    width: 80%;
                    border-collapse: collapse;
                    margin: 10px auto 40px auto;
                    }
                    th, td {
                    border: 1px solid black;
                    padding: 6px 10px;
                    text-align: center;
                    }
                    th {
                    background-color: lightblue;
                    }
                </style>
            </head>
            
            <body>
                <h1>BÀI XSLT - TRUY VẤN QUẢN LÝ BÀN ĂN</h1>
                
                <!-- bai1 -->
                <h2>1. Hiển thị danh sách tất cả các bàn</h2>
                <table>
                    <tr><th>STT</th><th>Số bàn</th><th>Tên bàn</th></tr>
                    <xsl:for-each select="QUANLY/BANS/BAN">
                        <tr>
                            <td><xsl:value-of select="position()"/></td>
                            <td><xsl:value-of select="SOBAN"/></td>
                            <td><xsl:value-of select="TENBAN"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                
                <!-- bai2 -->
                <h2>2. Hiển thị danh sách các nhân viên</h2>
                <table>
                    <tr><th>STT</th><th>Mã NV</th><th>Tên NV</th><th>Giới tính</th><th>Địa chỉ</th><th>SĐT</th></tr>
                    <xsl:for-each select="QUANLY/NHANVIENS/NHANVIEN">
                        <tr>
                            <td><xsl:value-of select="position()"/></td>
                            <td><xsl:value-of select="MANV"/></td>
                            <td><xsl:value-of select="TENV"/></td>
                            <td><xsl:value-of select="GIOITINH"/></td>
                            <td><xsl:value-of select="DIACHI"/></td>
                            <td><xsl:value-of select="SDT"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                
                <!-- bai3 -->
                <h2>3. Hiển thị danh sách các món ăn</h2>
                <table>
                    <tr><th>STT</th><th>Mã món</th><th>Tên món</th><th>Giá</th></tr>
                    <xsl:for-each select="QUANLY/MONS/MON">
                        <tr>
                            <td><xsl:value-of select="position()"/></td>
                            <td><xsl:value-of select="MAMON"/></td>
                            <td><xsl:value-of select="TENMON"/></td>
                            <td><xsl:value-of select="GIA"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                
                <!-- bai4 -->
                <h2>4. Hiển thị thông tin của nhân viên NV02</h2>
                <table>
                    <tr><th>Mã NV</th><th>Tên NV</th><th>Giới tính</th><th>Địa chỉ</th><th>SĐT</th></tr>
                    <xsl:for-each select="QUANLY/NHANVIENS/NHANVIEN[MANV='NV02']">
                        <tr>
                            <td><xsl:value-of select="MANV"/></td>
                            <td><xsl:value-of select="TENV"/></td>
                            <td><xsl:value-of select="GIOITINH"/></td>
                            <td><xsl:value-of select="DIACHI"/></td>
                            <td><xsl:value-of select="SDT"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                
                <!-- bai5 -->
                <h2>5. Hiển thị danh sách món ăn có giá &gt; 50,000</h2>
                <table>
                    <tr><th>STT</th><th>Mã món</th><th>Tên món</th><th>Giá</th></tr>
                    <xsl:for-each select="QUANLY/MONS/MON[GIA &gt; 50000]">
                        <tr>
                            <td><xsl:value-of select="position()"/></td>
                            <td><xsl:value-of select="MAMON"/></td>
                            <td><xsl:value-of select="TENMON"/></td>
                            <td><xsl:value-of select="GIA"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                
                <!-- bai6 -->
                <h2>6. Thông tin hóa đơn HD03</h2>
                <table>
                    <tr><th>Tên NV</th><th>Số bàn</th><th>Ngày lập</th><th>Tổng tiền</th></tr>
                    <xsl:for-each select="QUANLY/HOADONS/HOADON[SOHD='HD03']">
                        <tr>
                            <td>
                                <xsl:value-of select="/QUANLY/NHANVIENS/NHANVIEN[MANV=current()/MANV]/TENV"/>
                            </td>
                            <td><xsl:value-of select="SOBAN"/></td>
                            <td><xsl:value-of select="NGAYLAP"/></td>
                            <td><xsl:value-of select="TONGTIEN"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                
                <!-- bai7 -->
                <h2>7. Tên các món ăn trong hóa đơn HD02</h2>
                <table>
                    <tr><th>STT</th><th>Tên món</th></tr>
                    <xsl:for-each select="QUANLY/HOADONS/HOADON[SOHD='HD02']/CTHDS/CTHD">
                        <tr>
                            <td><xsl:value-of select="position()"/></td>
                            <td><xsl:value-of select="/QUANLY/MONS/MON[MAMON=current()/MAMON]/TENMON"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                
                <!-- bai8 -->
                <h2>8. Tên nhân viên lập hóa đơn HD02</h2>
                <table>
                    <tr><th>Tên nhân viên</th></tr>
                    <tr>
                        <td>
                            <xsl:value-of select="/QUANLY/NHANVIENS/NHANVIEN[MANV=/QUANLY/HOADONS/HOADON[SOHD='HD02']/MANV]/TENV"/>
                        </td>
                    </tr>
                </table>
                
                <!-- bai9 -->
                <h2>9. Đếm số bàn</h2>
                <table>
                    <tr><th>Tổng số bàn</th></tr>
                    <tr><td><xsl:value-of select="count(QUANLY/BANS/BAN)"/></td></tr>
                </table>
                
                <!-- bai10 -->
                <h2>10. Đếm số hóa đơn lập bởi NV01</h2>
                <table>
                    <tr><th>Số lượng hóa đơn</th></tr>
                    <tr><td><xsl:value-of select="count(QUANLY/HOADONS/HOADON[MANV='NV01'])"/></td></tr>
                </table>
                
                <!-- bai11 -->
                <h2>11. Danh sách món từng bán cho bàn số 2</h2>
                <table>
                    <tr><th>STT</th><th>Tên món</th></tr>
                    <xsl:for-each select="QUANLY/HOADONS/HOADON[SOBAN=2]/CTHDS/CTHD">
                        <tr>
                            <td><xsl:value-of select="position()"/></td>
                            <td><xsl:value-of select="/QUANLY/MONS/MON[MAMON=current()/MAMON]/TENMON"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                
                <!-- bai12 -->
                <h2>12. Danh sách nhân viên từng lập hóa đơn cho bàn số 3</h2>
                <table>
                    <tr><th>STT</th><th>Tên nhân viên</th></tr>
                    <xsl:for-each select="QUANLY/HOADONS/HOADON[SOBAN=3]">
                        <tr>
                            <td><xsl:value-of select="position()"/></td>
                            <td><xsl:value-of select="/QUANLY/NHANVIENS/NHANVIEN[MANV=current()/MANV]/TENV"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                
                <!-- bai13 -->
                <h2>13. Các món ăn được gọi nhiều hơn 1 lần</h2>
                <table>
                    <tr><th>STT</th><th>Tên món</th></tr>
                    <xsl:for-each select="QUANLY/MONS/MON">
                        <xsl:variable name="ma" select="MAMON"/>
                        <xsl:if test="sum(/QUANLY/HOADONS/HOADON/CTHDS/CTHD[MAMON=$ma]/SOLUONG) &gt; 1">
                            <tr>
                                <td><xsl:value-of select="position()"/></td>
                                <td><xsl:value-of select="TENMON"/></td>
                            </tr>
                        </xsl:if>
                    </xsl:for-each>
                </table>
                
                <!-- bai14 -->
                <h2>14. Hóa đơn chi tiết HD04</h2>
                <table>
                    <tr><th>Mã món</th><th>Tên món</th><th>Đơn giá</th><th>Số lượng</th><th>Thành tiền</th></tr>
                    <xsl:for-each select="QUANLY/HOADONS/HOADON[SOHD='HD04']/CTHDS/CTHD">
                        <tr>
                            <td><xsl:value-of select="MAMON"/></td>
                            <td><xsl:value-of select="/QUANLY/MONS/MON[MAMON=current()/MAMON]/TENMON"/></td>
                            <td><xsl:value-of select="/QUANLY/MONS/MON[MAMON=current()/MAMON]/GIA"/></td>
                            <td><xsl:value-of select="SOLUONG"/></td>
                            <td><xsl:value-of select="/QUANLY/MONS/MON[MAMON=current()/MAMON]/GIA * SOLUONG"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
