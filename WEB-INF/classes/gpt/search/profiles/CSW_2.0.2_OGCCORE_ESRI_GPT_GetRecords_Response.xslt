<?xml version="1.0" encoding="UTF-8"?>
<!--
 See the NOTICE file distributed with
 this work for additional information regarding copyright ownership.
 Esri Inc. licenses this file to You under the Apache License, Version 2.0
 (the "License"); you may not use this file except in compliance with
 the License.  You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
-->
<xsl:stylesheet version="1.0"  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  xmlns:csw="http://www.opengis.net/cat/csw/2.0.2" xmlns:dct="http://purl.org/dc/terms/" xmlns:ows="http://www.opengis.net/ows" xmlns:dc="http://purl.org/dc/elements/1.1/" exclude-result-prefixes="csw dc dct ows">
  <xsl:output method="xml" indent="no"  encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
 <xsl:choose>
  <xsl:when test="/ows:ExceptionReport">
        <exception>
          <exceptionText>
            <xsl:for-each select="/ows:ExceptionReport/ows:Exception">
              <xsl:value-of select="ows:ExceptionText"/>
            </xsl:for-each>
          </exceptionText>
        </exception>
   </xsl:when>
   <xsl:otherwise>
    <Records>
      <xsl:attribute name="maxRecords">
        <xsl:value-of select="/csw:GetRecordsResponse/csw:SearchResults/@numberOfRecordsMatched"/>
      </xsl:attribute>
      <xsl:for-each select="/csw:GetRecordsResponse/csw:SearchResults/csw:Record | /csw:GetRecordsResponse/csw:SearchResults/csw:BriefRecord | /csw:GetRecordByIdResponse/csw:Record | /csw:GetRecordsResponse/csw:SearchResults/csw:SummaryRecord">
        <Record>
          <ID>
            <xsl:choose>
                  <xsl:when test="string-length(normalize-space(dc:identifier[@scheme='urn:x-esri:specification:ServiceType:ArcIMS:Metadata:DocID']/text())) > 0">
                    <xsl:value-of select="normalize-space(dc:identifier[@scheme='urn:x-esri:specification:ServiceType:ArcIMS:Metadata:DocID'])"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="normalize-space(dc:identifier)"/>
                  </xsl:otherwise>
             </xsl:choose>
          </ID>
          <Title>
            <xsl:value-of select="dc:title"/>
          </Title>
          <Abstract>
            <xsl:value-of select="dct:abstract"/>
          </Abstract>
          <Type>
            <xsl:value-of select="dc:type"/>
          </Type>
          <LowerCorner>
          <xsl:value-of select="ows:WGS84BoundingBox/ows:LowerCorner"/>
          </LowerCorner>
          <UpperCorner>
          <xsl:value-of select="ows:WGS84BoundingBox/ows:UpperCorner"/>
          </UpperCorner>
          <MaxX>
                <xsl:value-of select="normalize-space(substring-before(ows:WGS84BoundingBox/ows:UpperCorner, ' '))"/>
              </MaxX>
              <MaxY>
                <xsl:value-of select="normalize-space(substring-after(ows:WGS84BoundingBox/ows:UpperCorner, ' '))"/>
              </MaxY>
              <MinX>
                <xsl:value-of select="normalize-space(substring-before(ows:WGS84BoundingBox/ows:LowerCorner, ' '))"/>
              </MinX>
              <MinY>
                <xsl:value-of select="normalize-space(substring-after(ows:WGS84BoundingBox/ows:LowerCorner, ' '))"/>
              </MinY>
              <ModifiedDate>
                <xsl:value-of select="./dct:modified"/>
              </ModifiedDate>
              <References>
                <xsl:for-each select="./dct:references">
                  <xsl:value-of select="."/>
                  <xsl:text>&#x2714;</xsl:text>
                  <xsl:value-of select="@scheme"/>
                  <xsl:text>&#x2715;</xsl:text>
                </xsl:for-each>
              </References>
              <Types>
                <xsl:for-each select="./dc:type">
                  <xsl:value-of select="."/>
                  <xsl:text>&#x2714;</xsl:text>
                  <xsl:value-of select="@scheme"/>
                  <xsl:text>&#x2715;</xsl:text>
                </xsl:for-each>
              </Types>
              <Links>
				<Link label="catalog.property.customLink.label.wms">
					<xsl:value-of select="./dct:references[@scheme='urn:x-esri:specification:ServiceType:wms:url']"/>
				</Link>
				<Link label="catalog.property.customLink.label.sos">
					<xsl:value-of select="./dct:references[@scheme='urn:x-esri:specification:ServiceType:sos:url']"/>
				</Link>
				<Link label="catalog.property.customLink.label.wcs">
					<xsl:value-of select="./dct:references[@scheme='urn:x-esri:specification:ServiceType:wcs:url']"/>
				</Link>
				<Link label="catalog.property.customLink.label.ags">
					<xsl:value-of select="./dct:references[@scheme='urn:x-esri:specification:ServiceType:ags:url']"/>
				</Link>					
				<Link label="catalog.property.customLink.label.las">
					<xsl:value-of select="./dct:references[@scheme='urn:x-esri:specification:ServiceType:las:url']"/>
				</Link>
				<Link label="catalog.property.customLink.label.wct">
					<xsl:value-of select="./dct:references[@scheme='urn:x-esri:specification:ServiceType:wct:url']"/>
				</Link>
				<!-- <Link label="catalog.property.customLink.label.odp">
					<xsl:value-of select="./dct:references[@scheme='urn:x-esri:specification:ServiceType:odp:url']"/>
				</Link>  -->											
			  </Links>
			  
        </Record>
      </xsl:for-each>

    </Records>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>
</xsl:stylesheet>
