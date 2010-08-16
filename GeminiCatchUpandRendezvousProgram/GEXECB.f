C       COPYRIGHT       NONE.  THIS CODE IS IN THE PUBLIC DOMAIN.
C       FILENAME        GEMINICATCHUPANDRENDEZVOUSPROGRAM/GEXECB.F
C       PURPOSE         THIS IS PART OF THE ORIGINAL 1965 SIMULATION
C                       PROGRAM FOR THE GEMINI 7/6 MISSION
C                       CATCH-UP AND RENDEZVOUS FLIGHT PHASES.
C                       THIS PARTICULAR FILE CONTAINS ONLY THE
C                       GEXECB SUBROUTINE (EXECUTOR FOR MATH FLOW
C                       7 BENCH), BY FERNEY HOUGH.
C       WEBSITE         WWW.IBIBLIO.ORG/APOLLO
C       HISTORY         2010-08-14 RSB  BEGAN TRANSCRIBING FROM
C                                       THE SCANNED PDF REPORT.
C
C       REFER TO MAIN.F FOR MORE-DETAILED INTRODUCTORY COMMENTS.
C
C       FROM PAGE 115 OF THE REPORT 
        SUBROUTINE GEXECB
        DIMENSION CXT(11),CYT(11),CZT(11),CDTWT(11)
        COMMON CDVXSP,CDVYSP,CDVZSP,CDPHSC,CDPSSC,CDTHSC,AKX1  ,AKX2  ,
       1AKX3  ,AKX4  ,AKYI  ,AKY2  ,AKY3  ,AKY4  ,AKZI  ,AKZ2  ,AKZ3  ,
       2AKZ4  ,ASFX  ,ASFY  ,ASFZ  ,CO    ,COI   ,C2    ,C2I   ,CA11  ,
       3CA12  ,CAI3  ,CA21  ,CA22  ,CA23  ,CA31  ,CA32  ,CA33  ,CAPT  ,
       4CAPTI ,CATXBA,CATXBI,CCAB  ,CCABI ,CCAS  ,CCAS1 ,CCK1  ,CCK2  ,
       5CCK3  ,CCK4  ,CCKS  ,CCKF  ,CCKG  ,CCPHIB,CCPSIB,CCPSIR,CCR   ,
       6CCRB  ,CCRBI ,CCRI  ,CCRS  ,CCRSI ,CCTHB ,CCTHR ,CCWSTD,CCWTOL,
       7CCZT  ,CDEL  ,CDRRD ,CDTM  ,CDTW  ,CDTWT ,CDTWX ,CDTX  ,CDV   ,
       8CDVF  ,CDVI  ,CDVT  ,CDVXB ,CDVXM ,CDVXS ,CDVXZ ,CDVYB ,CDVYM ,
       9CDVYS ,CDVYZ ,CDVZB ,CDVZM ,CDVZS ,CDVZZ ,CDXD  ,CDXFD ,CDYD
        COMMON CDYFD ,CDZD  ,CDZFD ,CFX   ,CFY   ,CFZ   ,CM1   ,CM3   ,
       1CM4   ,CM5   ,CM6   ,CNPC  ,CNS   ,CNVX  ,CNVY  ,CNVZ  ,CNYC  ,
       2COEFF ,COINT ,COMGS ,CPHIB ,CPHIBC,CPSBCP,CPSIB ,CPSIBC,CPSIBM,
       3CR1   ,CRA   ,CRLO  ,CRR   ,CRRD  ,CRRG  ,CRRI  ,CRRPI ,CRS   ,
       4CSADPI,CSAPG ,CSAPI ,CSAPR ,CSPHIB,CSPSIB,CSPSIR,CSRDPI,CSRPG ,
       5CSRPI ,CSRPR ,CSRT  ,CSRTI ,CSTD  ,CSTOL ,CSTHB ,CSTHR ,CSTZ  ,
       6CSWSTD,CSWTDL,CT    ,CTD   ,CTDAS ,CTDV  ,CTHB  ,CTHBC ,CTHBCP,
       7CTHBM ,CTLRP ,CTM   ,CTR1  ,CTRR  ,CTTG  ,CTW   ,CTX   ,CUDPHS,
       8CUDPSS,CUDTHS,CWSTD ,CWSTDL,CWTTPR,CX    ,CXM   ,CXRD  ,CXSD  ,
       9CXT   ,CXTD  ,CXZ   ,CY    ,CYM   ,CYRD  ,CYSD  ,CYT   ,CYTD
        COMMON CYZ   ,CZ    ,CZM   ,CZRD  ,CZSD  ,CZT   ,CZTD  ,CZZ   ,
       1DELAY ,DONPRT,DT    ,DUM1  ,DUM2  ,DUM3  ,DUM4  ,DUM5  ,DUM6  ,
       2DUM7  ,DUM8  ,DUM9  ,DUM10 ,DUM11 ,DUM12 ,DUM13 ,DUM14 ,DUM15 ,
       3DUM16 ,DUMI7 ,DUMI8 ,FIN   ,FP    ,FXP   ,FXPP  ,FYP   ,FYPP  ,
       4FZP   ,FZPP  ,GC    ,IC    ,IEXIT ,IOLP  ,IWRITE,K2C   ,KC    ,
       5KWRITE,L     ,LC1   ,LC1J  ,LC2   ,LC3   ,LC4A  ,LC4B  ,LC4C  ,
       6LC4D  ,LC4E  ,LC4F  ,LC4G  ,LC5   ,LC7   ,LC8   ,LC10  ,LCA   ,
       7LCS   ,LCY   ,LDI00 ,LDI10 ,LDI11 ,LDI13 ,LDI20 ,LDI21 ,LDI22 ,
       8LDI25 ,LDI26 ,LDI31 ,LDO01 ,LDO05 ,LDO11 ,LDO12 ,LDO13 ,LDO62 ,
       9LDO63 ,LFDI  ,LQT   ,M     ,N     ,PHIB  ,PINT  ,PSIB  ,RDGD
        COMMON RRDREF,SRAA  ,SREA  ,SW    ,TEST  ,TFTXV ,TFTYV ,TFTZV ,
       1THETAB,TIME  ,TPC   ,TRI   ,TSC   ,TVX   ,TVY   ,TVZ   ,TYC   ,
       2XGRT  ,XGRTD ,XKRDR ,YGRT  ,YGRTD ,ZGRT  ,ZGRTD
        EQUIVALENCE (DELVX,CDVXSP),(DELVY,CDVYSP),(DELVZ,CDVZSP),
       1(CDPHSC,DPHIB),(CDPSSC,DPSIB),(CDTHSC,DTHB),(VLIST,CDVXSP)
        IF (LCX) 8,101,8
 101    LC4A=0
        LC4B=0
        LC4C=0
        LC4D=0
        LC4E=0
        LC4G=0
        LCY=0
        LCX=4095
 8      IF (LCY) 105,102,105
 102    LDO62=0
        LDO05=0
        CT=0
        LCY=4095
 105    CALL GONOGO
 103    CT=CT+DT
 111    IF (LDI32) 112,1016,112
 112    CALL AGE
 1016   IF (LDI11) 1025,1020,1025
C
C       FROM PAGE 116 OF THE REPORT 
 1020   IF (LDI10) 1021,1023,1021
 1023   LC4A=0
        LC4B=0
        LC4C=0
        LC4D=0
        LC4G=0
        TEST=0.
        LCY=0
        RETURN
 1021   IF (LDI13) 7,6,7
 6      CALL ASCENT (LC4A,LC4B,LC4C,LC4D,LC4E,LC4G,LCY)
        RETURN
 7      CALL RNDZ
        RETURN
 1025   IF (LDI10) 1032,1019,1032
 1032   LC4A=0
        LC4B=0
        LC4C=0
        LC4D=0
        LC4G=0
        LDO05=0
        RETURN
 1019   IF (LDI13) 5,4,5
 4      CALL RNDZ
 5      CALL REENT  (LC4A,LC4B,LC4C,LC4D,LC4E,LC4G,LCY)
        RETURN
        END(1,1,0,0,0,0,1,1,0,0,0,0,0,0,0)
