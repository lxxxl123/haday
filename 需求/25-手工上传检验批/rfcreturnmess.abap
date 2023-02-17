LPARAMETERS lnCommit,loRETURNTABLE,loFuncCOMM
IF USED('iCur_Return')
	USE IN iCur_Return
ENDIF 			    
tciCur = 'iCur_Return'
 				     This.builditab(tciCur ,m.loRETURNTABLE)
*获取SAP内表中的内容
Local liRecn,lcColname
For m.liRecn = 1 To m.loRETURNTABLE.RowCount
    Select &tciCur
    Append Blank 
    For Each m.loColumn In m.loRETURNTABLE.Columns         && 字段值

    	lcColName = m.loColumn.Name
    	
    	*特殊处理BCD类型(QUAN),好像传到VFP里面内容变成字符型
    	Do case 
    		Case "BCD" $ m.loColumn.typename
    			replace &tciCur..&lcColName. with Val(m.loRETURNTABLE.Value(m.liRecn, m.loColumn.Name))
*!*	            		Case "Time" $ m.loColumn.typename
*!*	            			replace &tciCur..&lcColName. with time(m.loTable.Value(m.liRecn, m.loColumn.Name))
    		Otherwise
    			replace &tciCur..&lcColName. with m.loRETURNTABLE.Value(m.liRecn, m.loColumn.Name)
    	EndCase 
    Endfor
ENDFOR
icMess  = ''
IF USED('iCur_Return')
 	IF RECCOUNT('iCur_Return')>0
 		SELECT iCur_Return
 					icMess  = ''
		SCAN ALL 
 			icMess = icMess +CHR(13) +"["+ALLTRIM(STR(RECNO('iCur_Return')))+"]."+ ALLTRIM(iCur_Return.Message)
 		ENDSCAN 
 		USE IN iCur_Return
 		IF !EMPTY(icMess)
 			This.iupsqlmess( " BAPI函数执行后返回信息:"+icMess +CHR(13),90)
 			This.savemesstosql()
 	 		RETURN .F.
 		ENDIF 
 	ELSE
 		USE IN iCur_Return
	 	IF !EMPTY(lnCommit)
	  		IF	m.loFuncCOMM.Call
				This.iupsqlmess( "   BAPI 提交成功!")
	    		this.dupdate = getsysdate(,.T.)
				this.lupdate = .T. 
				This.savemesstosql()					
	    	ELSE
	    		This.iupsqlmess( "   ********BAPI 提交失败!*********",97)
	    		RETURN .F.
	    	ENDIF 
	    ENDIF 
 	ENDIF 
ELSE
 	IF !EMPTY(lnCommit)
  		IF	m.loFuncCOMM.Call
			This.iupsqlmess( "   BAPI 提交成功!")
    		this.dupdate = getsysdate(,.T.)
			this.lupdate = .T. 
			This.savemesstosql()				
    	ELSE
    		This.iupsqlmess( "   ********BAPI 提交失败!*********",97)
	  		RETURN .F.
    	ENDIF 
    ENDIF 
ENDIF
 

RETURN 
