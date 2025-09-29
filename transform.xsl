<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- Ключи для группировки -->
  <xsl:key name="by-city" match="item" use="@city"/>
  <xsl:key name="by-city-org" match="item" use="concat(@city,'|',@org)"/>
  <xsl:key name="by-city-org-title" match="item" use="concat(@city,'|',@org,'|',@title)"/>

  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/orgs">
    <html>
      <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <title>Города</title>
        <style>
          body{font-family:system-ui,Segoe UI,Roboto,Arial,sans-serif;margin:20px;color:#111}
          h1{margin:0 0 12px 0}
          ul{margin:0 0 12px 22px}
          li{margin-bottom:10px}
          h3{margin:8px 0}
          h4{margin:6px 0}
          .muted{color:#666}
        </style>
      </head>
      <body>
        <h1>Города и компании</h1>
        <ul>
          <xsl:for-each select="item[generate-id() = generate-id(key('by-city', @city)[1])]">
            <xsl:sort select="@city"/>
            <li>
              <h3><xsl:value-of select="@city"/></h3>
              <p class="muted">
                Всего товаров:
                <xsl:value-of select="count(key('by-city', @city))"/>
              </p>

              <xsl:for-each select="key('by-city', @city)[generate-id() = generate-id(key('by-city-org', concat(@city,'|',@org))[1])]">
                <xsl:sort select="@org"/>
                <ul>
                  <li>
                    <h4><xsl:value-of select="@org"/></h4>
                    <p class="muted">
                      Всего товаров:
                      <xsl:value-of select="count(key('by-city-org', concat(@city,'|',@org)))"/>
                    </p>
                    <ul>
                      <xsl:for-each select="key('by-city-org', concat(@city,'|',@org))[generate-id() = generate-id(key('by-city-org-title', concat(@city,'|',@org,'|',@title))[1])]">
                        <xsl:sort select="@title"/>
                        <li><xsl:value-of select="@title"/></li>
                      </xsl:for-each>
                    </ul>
                  </li>
                </ul>
              </xsl:for-each>
            </li>
          </xsl:for-each>
        </ul>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
