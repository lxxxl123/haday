LPARAMETERS m.loRow

m.loRow.Value("INSPLOT") = ALLTRIM(iCur_Sample.PRUEFLOS)	&& Evaluate("PRUEFLOS")
m.loRow.Value("INSPOPER") = ALLTRIM(iCur_Sample.Vornr2)
IF EMPTY(ALLTRIM(iCur_Sample.Vornr2))
	This.iupsqlmess(' 工序号为空错误,请纠正...',5)
	RETURN .F.
ENDIF 	  		        
m.loRow.Value("INSPPOINT") =   ALLTRIM(iCur_Sample.PROBENR)
IF EMPTY(ALLTRIM(iCur_Sample.PROBENR))
	This.iupsqlmess(  ' 计数器为空错误,请纠正...',5)
	RETURN .F.
ENDIF 	    
     	
IF ALLTRIM(iCur_Sample.slwbezX)  = '200' OR  ALLTRIM(iCur_Sample.slwbezX)  = '210'
	IF EMPTY(iCur_Sample.PHYNR)
		This.iupsqlmess(  'PHYNR为空错误,请纠正...',5)
		RETURN .F.
	ENDIF 
	m.loRow.Value("PHYS_SMPL") =   ALLTRIM(iCur_Sample.PHYNR)  && 200 与 210 时需要,且不能为空
ENDIF 
*==============================
IF ALLTRIM(iCur_Sample.slwbezX)  = '110'
	IF EMPTY(iCur_Sample.USERC1)
		This.iupsqlmess( ' USERC1为空错误,请纠正...',5)
		RETURN .F.
	ENDIF 				
	m.loRow.Value("USERC1") = ALLTRIM(iCur_Sample.USERC1)	&& 110 需要,且不能为空
ENDIF 

IF ALLTRIM(iCur_Sample.slwbezX)  = '100' OR ALLTRIM(iCur_Sample.slwbezX)  = '210'
	IF EMPTY(iCur_Sample.USERC2)
		This.iupsqlmess(  ' USERC2为空错误,请纠正...',5)
		RETURN .F.
	ENDIF 		
	m.loRow.Value("USERC2") = ALLTRIM(iCur_Sample.USERC2)	&& 100 与 210 时需要,且不能为空
ENDIF 
IF   ALLTRIM(iCur_Sample.slwbezX)  = 'C10'
	IF EMPTY(iCur_Sample.USERN1)
		This.iupsqlmess( ' USERN1为空错误,请纠正...',5)
		RETURN .F.
	ENDIF 						
	m.loRow.Value("USERN1") = ALLTRIM(iCur_Sample.USERN1)	&& C01 需要,且不能为空
ENDIF 
IF ALLTRIM(iCur_Sample.slwbezX)  = '100' OR ALLTRIM(iCur_Sample.slwbezX)  = '210'
	IF EMPTY(iCur_Sample.USERN2)
		This.iupsqlmess( ' USERN2为空错误,请纠正...',5)
		RETURN .F.
	ENDIF 	
	m.loRow.Value("USERN2") = ALLTRIM(iCur_Sample.USERN2)	&& 100 与 210 时需要,且不能为空
ENDIF 
 icTime =  ""
m.loRow.Value("USERD1") = DTOC(iCur_Sample.USERD)
icTime = RIGHT(TTOC(iCur_Sample.USERD),8)
icTime = ALLTRIM(icTime)
icTime = REPLICATE('0',8-LEN(ALLTRIM(icTime))) + icTime

IF icTime = '00:00:00'
	icTime  = '23:59:59'
*	This.iupsqlmess( ' 检验时间为00:00:00错误,请纠正...',5)
*	RETURN .F.
ENDIF 
icTime = ALLTRIM(icTime)
&& DTOS(iCur_Sample.USERD) + 
m.loRow.Value("USERT1") = LEFT(icTime,2) + RIGHT(Left(icTime,5),2)+RIGHT(icTime,2)


m.loRow.Value("INSPECTOR") =  ALLTRIM(iCur_Sample.cLogin)
m.loRow.Value("INSP_DATE") = DTOS(iCur_Sample.dCrtDate)
icTime = RIGHT(TTOC(iCur_Sample.dCrtDate),8)
icTime = ALLTRIM(icTime )
icTime = REPLICATE('0',8-LEN(ALLTRIM(icTime))) + icTime

IF icTime = '00:00:00'
	icTime  = '23:59:59'
*	This.iupsqlmess( '检验点生成时间为00:00:00错误,请纠正...',5)
*	RETURN .F.
ENDIF 		
icTime = ALLTRIM(icTime)		
m.loRow.Value("INSP_TIME") = 	 LEFT(icTime,2) + RIGHT(Left(icTime,5),2)+RIGHT(icTime,2)

IF !(EMPTY(iCur_Sample.CCDGTNO) OR EMPTY(iCur_Sample.cCDGPNO) OR EMPTY(iCur_Sample.cUDCODE)) && 评估
	m.loRow.Value("CAT_TYPE") = "3"		&&ALLTRIM(iCur_Sample.KATALGART1)  目录类型固化为 3 
	m.loRow.Value("PSEL_SET") = ALLTRIM(iCur_Sample.WERK)
	m.loRow.Value("SEL_SET") =  ALLTRIM(iCur_Sample.CCDGTNO)
	m.loRow.Value("CODE_GRP") = ALLTRIM(iCur_Sample.cCDGPNO)
	m.loRow.Value("CODE") = ALLTRIM(iCur_Sample.cUDCODE)
*	m.loRow.Value("REMARK") = ALLTRIM(iCur_Sample.cCODENAME)
ENDIF 
RETURN .T.