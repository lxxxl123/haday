LPARAMETERS m.loRow2
m.loRow2.Value("INSPLOT")  = ALLTRIM(this.cprueflos )
m.loRow2.Value("INSPOPER") = ALLTRIM(iCur_QASR.VORNR)
IF EMPTY(ALLTRIM(iCur_QASR.VORNR))
	This.iupsqlmess( ' 工序号为空错误,请纠正...',5)
	RETURN .F.
ENDIF 	     
		        
m.loRow2.Value("INSPSAMPLE") =  iCur_Sample.PROBENR

IF EMPTY(ALLTRIM(iCur_Sample.PROBENR))
	This.iupsqlmess( '计数器为空错误,请纠正...',5)
	RETURN .F.
ENDIF 	     			        
m.loRow2.Value("INSPCHAR") = ALLTRIM(iCur_QASR.MERKNR)
*!*	IF RIGHT(LEFT(iCur_Sample.steuerkz,8),1) = 'X' AND (iCur_QASR.SATZSTATUS = '4' OR iCur_QASR.SATZSTATUS = '5')
*!*	    m.loRow2.Value("CLOSED")	 = 'X'			&&待增加逻辑
*!*	Endif 
	    m.loRow2.Value("CLOSED")	 = 'X'			&&待增加逻辑 =========================
IF EMPTY(iCur_QASR.AUSWMENGE1)
    IF LEFT(ALLTRIM(iCur_QASR.MESSWERTE),1)= '>' OR LEFT(ALLTRIM(iCur_QASR.MESSWERTE),1)= '<'
    	m.loRow2.Value("MEAN_VALUE") =  RIGHT(ALLTRIM(iCur_QASR.MESSWERTE),LEN(ALLTRIM(iCur_QASR.MESSWERTE))-1)
    	m.loRow2.Value("SMPL_ATTR") = LEFT(ALLTRIM(iCur_QASR.MESSWERTE),1)
    	m.loRow2.Value("ORIGINAL_INPUT") = iCur_QASR.MESSWERTE

    ELSE 
    	IF LEFT(ALLTRIM(iCur_QASR.MESSWERTE),2) = "＜" OR LEFT(ALLTRIM(iCur_QASR.MESSWERTE),2) = "＞"
    		m.loRow2.Value("MEAN_VALUE") =  RIGHT(ALLTRIM(iCur_QASR.MESSWERTE),LEN(ALLTRIM(iCur_QASR.MESSWERTE))-2)
    		m.loRow2.Value("SMPL_ATTR") =IIF(LEFT(ALLTRIM(iCur_QASR.MESSWERTE),2) = "＜",'<','>')	&& LEFT(ALLTRIM(iCur_QASR.MESSWERTE),2)
    		m.loRow2.Value("ORIGINAL_INPUT") = IIF(LEFT(ALLTRIM(iCur_QASR.MESSWERTE),2) = "＜",'<','>') + RIGHT(ALLTRIM(iCur_QASR.MESSWERTE),LEN(ALLTRIM(iCur_QASR.MESSWERTE))-2)

    	ELSE
    		m.loRow2.Value("MEAN_VALUE") = iCur_QASR.MESSWERTE
    		m.loRow2.Value("ORIGINAL_INPUT") = iCur_QASR.MESSWERTE
    	ENDIF 
    ENDIF 
* 	MESSAGEBOX(m.loRow2.Value("MEAN_VALUE") +"||"+m.loRow2.Value("SMPL_ATTR")+"||"+m.loRow2.Value("ORIGINAL_INPUT") )
*SAMPLE_RESULTS-MEAN_VALUE = '1'.
*SAMPLE_RESULTS-SMPL_ATTR = '>'.
*SAMPLE_RESULTS-ORIGINAL_INPUT = '>1'.
ELSE
	m.loRow2.Value("CODE1") = ALLTRIM(iCur_QASR.cCodeNO)
	m.loRow2.Value("Code_GRP1") = ALLTRIM(iCur_QASR.cCodeGPNO)
*	m.loRow2.Value("ORIGINAL_INPUT") = ALLTRIM(iCur_QASR.cCodeName)
ENDIF 

m.loRow2.Value("INSPECTOR") =  ALLT(iCur_QASR.cLogin)
m.loRow2.Value("START_DATE") = DTOS(iCur_QASR.dVTDate)
icTime = RIGHT(TTOC(iCur_QASR.dVTDate),8)
IF icTime = '00:00:00'
	icTime  = '23:59:59'
*	This.iupsqlmess( ' 检验时间为00:00:00错误,请纠正...',5)
*	RETURN .F.
ENDIF 		
icTime = ALLTRIM(icTime)
icTime = REPLICATE('0',8-LEN(ALLTRIM(icTime))) + icTime

m.loRow2.Value("START_TIME") =   LEFT(icTime,2) + RIGHT(Left(icTime,5),2)+RIGHT(icTime,2)
m.loRow2.Value("END_DATE") = DTOS(iCur_QASR.dClsDate)
icTime = RIGHT(TTOC(iCur_QASR.dClsDate),8)
IF icTime = '00:00:00'
	icTime  = '23:59:59'
*	This.iupsqlmess( ' 检验时间为00:00:00错误,请纠正...',5)
*	RETURN .F.
ENDIF 					
icTime = ALLTRIM(icTime)
icTime = REPLICATE('0',8-LEN(ALLTRIM(icTime))) + icTime
m.loRow2.Value("END_TIME") = LEFT(icTime,2) + RIGHT(Left(icTime,5),2)+RIGHT(icTime,2)


m.loRow2.Value("RES_ORG") = iCur_QASR.Res_org
RETURN .T.