<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
    
    <xsl:template match="/">
        <html>
            <head>
                <meta charset="UTF-8"/>
                <title>Kết quả truy vấn sinh viên</title>
                
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
                    text-align: left;
                    }
                    th {
                    background-color: lightblue;
                    text-align: center;
                    }
                </style>
            </head>
            <body>
                
                <h1 style="text-align:center;">BÀI 1 - TRUY VẤN SINH VIÊN (XSLT)</h1>
                
                <!-- Liệt kê mã và họ tên -->
                <h2>1. Liệt kê thông tin của tất cả sinh viên gồm mã và họ tên</h2>
                <table>
                    <tr><th>Mã sinh viên</th><th>Họ tên</th></tr>
                    <xsl:apply-templates select="school/student" mode="mahoten"/>
                </table>
                
                <!--  Mã, tên, điểm (sắp xếp giảm dần) -->
                <h2>2. Danh sách sinh viên gồm mã, tên, điểm (sắp xếp theo điểm giảm dần)</h2>
                <table>
                    <tr><th>Mã sinh viên</th><th>Họ tên</th><th>Điểm</th></tr>
                    <xsl:for-each select="school/student">
                        <xsl:sort select="grade" data-type="number" order="descending"/>
                        <xsl:apply-templates select="." mode="madten"/>
                    </xsl:for-each>
                </table>
                
                <!--  Sinh viên sinh tháng gần nhau -->
                <h2>3. Danh sách sinh viên sinh tháng gần nhau (STT, Họ tên, Ngày sinh)</h2>
                <table>
                    <tr><th>STT</th><th>Họ tên</th><th>Ngày sinh</th></tr>
                    <xsl:for-each select="school/student">
                        <xsl:sort select="substring(date,6,2)" data-type="number" order="ascending"/>
                        <tr>
                            <td><xsl:value-of select="position()"/></td>
                            <td><xsl:value-of select="name"/></td>
                            <td><xsl:value-of select="date"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                
                <!--  Danh sách các khóa học có sinh viên học -->
                <h2>4. Danh sách các khóa học có sinh viên học (sắp xếp theo tên khóa học)</h2>
                <table>
                    <tr><th>Mã khóa học</th><th>Tên khóa học</th></tr>
                    <xsl:for-each select="school/course">
                        <xsl:sort select="name"/>
                        <tr>
                            <td><xsl:value-of select="id"/></td>
                            <td><xsl:value-of select="name"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                
                <!--  Sinh viên đăng ký khóa học "Hóa học 201" -->
                <h2>5. Danh sách sinh viên đăng ký khóa học "Hóa học 201"</h2>
                <table>
                    <tr><th>Mã SV</th><th>Họ tên</th></tr>
                    <xsl:for-each select="school/enrollment[courseRef = 'c3']">
                        <xsl:variable name="id" select="studentRef"/>
                        <xsl:apply-templates select="/school/student[id = $id]" mode="mahoten"/>
                    </xsl:for-each>
                </table>
                
                <!--  Sinh viên sinh năm 1997 -->
                <h2>6. Danh sách sinh viên sinh năm 1997</h2>
                <table>
                    <tr><th>Mã SV</th><th>Họ tên</th><th>Ngày sinh</th></tr>
                    <xsl:apply-templates select="school/student[starts-with(date,'1997')]" mode="nam1997"/>
                </table>
                
                <!--  Thống kê sinh viên họ "Trần" -->
                <h2>7. Thống kê danh sách sinh viên họ “Trần”</h2>
                <table>
                    <tr><th>Mã SV</th><th>Họ tên</th></tr>
                    <xsl:apply-templates select="school/student[starts-with(name, 'Trần')]" mode="mahoten"/>
                </table>
                
            </body>
        </html>
    </xsl:template>
    
    
    
    <!-- Mã + Họ tên -->
    <xsl:template match="student" mode="mahoten">
        <tr>
            <td><xsl:value-of select="id"/></td>
            <td><xsl:value-of select="name"/></td>
        </tr>
    </xsl:template>
    
    <!-- Mã + Tên + Điểm -->
    <xsl:template match="student" mode="madten">
        <tr>
            <td><xsl:value-of select="id"/></td>
            <td><xsl:value-of select="name"/></td>
            <td><xsl:value-of select="grade"/></td>
        </tr>
    </xsl:template>
    
    <!-- Mã + Tên + Ngày sinh -->
    <xsl:template match="student" mode="nam1997">
        <tr>
            <td><xsl:value-of select="id"/></td>
            <td><xsl:value-of select="name"/></td>
            <td><xsl:value-of select="date"/></td>
        </tr>
    </xsl:template>
    
</xsl:stylesheet>
