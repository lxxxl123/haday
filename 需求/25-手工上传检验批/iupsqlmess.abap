LPARAMETERS icMess,inMessType
	This.icEndMess = " 检验批号:"+ALLTRIM(this.cprueflos)  +  m.icMess 
	IF LEN(	This.icerrmess ) < 8000
		This.icerrmess  = This.icerrmess  + CHR(13)+CHR(10)+ icMess
	ELSE
		This.icerrmess =  icMess	
	ENDIF 
	 
	IF !EMPTY(inMessType)
    		this.dupdate = CTOD("")
			this.lupdate = .F. 	
*!*			IF This.ilReUpLoad		&&从日志上传不需要重复保存错误
*!*				RETURN 
*!*			ENDIF 
	
		IF !this.SaveMessToSQL()
			RETURN .F.
		ENDIF 
		
	ENDIF 
*	This.infmsg(icMess)

RETURN 