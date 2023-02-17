LOCAL icSQLString

IF EMPTY(This.dupdate)
    This.dupdate = CTOD('1900.01.01')
ENDIF 

    TEXT TO icSQLString TEXTMERGE NOSHOW 
        INSERT QC_UPLoadErrDataLog ( 
            nSMPID 
           ,cVTID
           ,cSMPNO
           ,cVTNO 
           ,cPrueflos 
           ,lSecular 
           ,nIsTest 
           ,tcFName 
           ,nCrtUser
           ,dCrtDate
           ,cPCName 
           ,cFormName
           ,cMessage 
           ,cEndMessage
           ,dUpdate
           ,lUpDate
             ) values ( 
             <<this.nsmpid>>
           ,  '<<this.cvtid>>'
           ,  '<<This.csmpno>>'
           , '<<This.cvtno>>'
           , '<<This.cprueflos>>'
           ,  <<this.lSecular>>
           ,  <<This.nistest>>
           ,  '<<This.cfname>>'
           ,  <<goUsercard.nID>>
           , Getdate()
           ,  '<<goUsercard.CPCUSER>>'
           ,  '<<This.icformname>>'
           ,  '<<this.icerrmess>>'
           , '<<LEFT(This.icendmess,100)>>'	
           , '<<This.dupdate>>'
           , <<IIF(This.lupdate,1,0)>>		 
             )
    ENDTEXT 
    IF !getsqlcursor('iCur_Mess',icSQLString,.t.,'QC')
        This.inStatus = 10
        RETURN .F.
    ENDIF 