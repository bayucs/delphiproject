unit uCommon;

interface

uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, DBGridEh,
    Dialogs, StdCtrls, ExtCtrls, INIFiles, Ora, DB, AES, jpeg, DBGridEhImpExp,
    ShellAPI;
const
    // Ȩ�޹���, ģ���
    Mdl_ifUse = 0; //�Ƿ����
    Mdl_limit = 1; //Ȩ�޹���
    Mdl_photoStat = 2; //����ͳ��
    Mdl_photoQuery = 3; //���ղ�ѯ
    Mdl_import = 4; //������Ƭ
    Mdl_export = 5; //������Ƭ
    Mdl_addCust = 6; //������Ա��Ϣ
    Mdl_EditCust = 7; //�޸���Ա��Ϣ

    Mdl_stuPrint = 8; //ѧ������ӡ
    Mdl_empPrint = 9; //��ʦ����ӡ
    Mdl_delphoto = 10; //ɾ����Ƭ
    mdl_savephoto = 11; //������Ƭ
    mdl_custImport = 12; //��Ա����

    selectH = 316;
    selectW = 230;
    imgW = 420;

    sCustomerConfig = '..\config\' + 'customer.ini';
    sDbConfig = '..\config\' + 'dbconfig.ini';
    sPrintTemplateDir = '..\print\';
    CryptKey = 'Splus321'; //����������ԿΪksykt123
var
    useRemoteSoft: Boolean; //ʹ�õ�����Զ����������,ʹ��Ϊtrue

    ifconn: Boolean; //�Ƿ����������ݿ�
    apppath: string; //ϵͳ�ļ�·��
    connStr: string; //���ݿ������ַ���
    dbName: string; //���ݿ�����
    dburl: string; //���ݿ����Ӵ�
    dbUid: string; //��¼���ݿ��û���
    dbPwd: string; //��¼���ݿ�����

    tblPhoto: string; //��Ƭ��
    tblDept: string; //���ű�
    tblSpec: string; //רҵ��
    tblDict: string; //�����ֵ�
    tblCust: string; //�ͻ���
    tblArea: string; //�����
    tblCutType: string; //�ͻ�����
    tblLimit: string; //Ȩ�ޱ�
    tblFeeType: string; //�շ�����
    tblSysKey: string; //ϵͳ��ֵ��
    tblCard: string; //����

    custId: string; //�ͻ���
    stuempNo: string; //ѧ����
    custName: string; //����
    custType: string; //��Ա���
    custState: string; //�ͻ�״̬
    custArea: string; //�ͻ���������
    custSex: string; //�Ա�
    custCardId: string; //����֤��
    custDeptNo: string; //�ͻ����ڲ��ź�
    custSpecNo: string; //�ͻ�����רҵ��
    custRegTime: string; //�ͻ�ע��ʱ��
    custFeeType: string; //�շ����
    classNo: string; //�༶
    batchNo: string; //���κ�
    extField1: string; //��չ�ֶ�1
    extField2: string; //��չ�ֶ�2

    pPhoto: string; //��Ƭ
    PMinPhoto: string; //С��Ƭ
    pIfCard: string; //�Ƿ��ƿ�
    pCardDate: string; //�ƿ�����
    pCardTime: string; //�ƿ�ʱ��
    pPhotoDate: string; //��������
    pPhotoTime: string; //����ʱ��
    pPhotoDTime: string; //���վ�ȷʱ�䣬������
    res_1: string; //Ԥ���ֶ�
    res_2: string;
    res_3: string;

    lmtOperCode: string; //����Ա����
    lmtOperName: string; //����Ա����
    lmtBeginDate: string; //��Чʱ��
    lmtEndDate: string; //ʵЧʱ��
    lmtpwd: string; //����
    lmtLimit: string; //Ȩ��
    lmtEnabled: string; //�Ƿ����

    deptCode: string; //���Ŵ���
    deptName: string; //��������
    deptParent: string; //�������
    deptLevel: string; //���ż���

    specCode: string; //רҵ����
    specName: string; //רҵ����

    dictNo: string; //�ֵ���
    dictValue: string; //�ֵ��ӱ��
    dictCaption: string; //�ֵ�����

    areaNo: string; //������
    areaName: string; //��������
    areaFather: string; //���򸸱��

    typeNo: string; //�����
    typeName: string; //�������

    cpIfCard: string; //��Ƭ��ӡ����ʾ�Ƿ��ƿ�
    cpCardDate: string; //�ƿ�����
    cpCardTime: string; //�ƿ�ʱ��


    loginLimit: string; //��¼��ͻ���Ȩ��
    loginName: string; //��¼��
    loginPwd: string; //��¼����

    feeFeeType: string; //������
    feeFeeName: string; //�������

    keyCode: string; //��ֵ����
    keyName: string; //��ֵ����
    keyValue: string; //��ֵ����
    keyMaxValue: string; //����ֵ
    keyCustId: string; //�ͻ����ڼ�ֵ���еĴ���

    cardCardId: string; //����
    cardStateId: string; //��״̬
    cardCustId: string; //�ͻ���

    photopath: string; //��Ƭ����λ��
    photopre: string; //��Ƭǰ׺
    diskpath: string; //����λ��

    rotate: Boolean; //�Ƿ���ת
    angle: Integer; //��ת�Ƕ�

    minWidth: Integer; //С��Ƭ�Ŀ���
    minHeight: Integer; //С��Ƭ�ĸ߶�

    //ȡ����������ʾ��λ������
    ve_visible: Boolean;
    veL_top: Integer;
    veL_left: Integer;
    veL_height: Integer;

    veR_top: Integer;
    veR_left: Integer;
    veR_height: Integer;

    veT_top: Integer;
    veT_left: Integer;
    veT_width: Integer;

    veB_top: Integer;
    veB_left: Integer;
    veB_width: Integer;

    veA_top: Integer;
    veA_left: Integer;
    veA_width: Integer;

    pageOrien: string;

procedure getphotoconfigs;
procedure AddData(cbb: TComboBox; sqlstr: string);
function subString(ssname: string; str: string; posi: string): string;
function sqlExec(sqlstr: string; rname: string): string;
function getDeptName(sDeptCode: string): string;
function getSName(ssCode: string): string;
function getAreaName(sareaNo: string): string;
function getStatesName(StateNo: string): string;
function getTypeName(stypeNo: string): string;
function getCardNo(custId: string): string;

function queryBaseInfoSql(sstuempNo: string; sareaId: string; scustId: string): string;
function getPhotoInfo(scustId: string): TJpegImage;

function getJpgNo(jpgName: string): string;

function ExportData(SaveDialog1: TSaveDialog; DBGridEh1: TDBGridEh): Boolean;

function haveStuEmpNo(sstuEmpNo: string): Boolean;

function qryOperSql(soperCode: string; spwd: string): string;

function judgelimit(oper: string; code: integer): boolean;

procedure insertPhotoData(sCustId, sStuempNo: string);

function getMaxCustId(): Integer;

function addCustInfo(sstuempNo, sname, stype, sArea, scardId, sDept, sSpec, sFeeType: string): Boolean;

procedure delFileBat(filePath, fileName: string);

function getDbTime: string;

implementation

uses uDM, mainUnit;
{-------------------------------------------------------------------------------
  ������:    getphotoconfigs�õ���Ƭ���е������ļ�
  ����:      ��
  ����ֵ:    ��
-------------------------------------------------------------------------------}

procedure getphotoconfigs;
var
    photoinifile: TIniFile;
    dbconfig: TIniFile;
begin
    photoinifile := nil;
    dbconfig := nil;
    if FileExists(apppath + sCustomerConfig) = false then begin
        Application.MessageBox('ϵͳ�����ļ��Ѿ����ƻ�������ϵͳ����Ա��ϵ��',
            'ϵͳ����', mb_ok + mb_iconerror);
        Application.Terminate;
    end;
    try
        photoinifile := TIniFile.Create(apppath + sCustomerConfig);
        dbconfig := TIniFile.Create(apppath + sDbConfig);

        tblPhoto := photoinifile.ReadString('tablename', 'tblphoto', '');
        tblDept := photoinifile.ReadString('tablename', 'tbldept', '');
        tblSpec := photoinifile.ReadString('tablename', 'tblspec', '');
        tblDict := photoinifile.ReadString('tablename', 'tbldict', '');
        tblCust := photoinifile.ReadString('tablename', 'tblcust', '');
        tbllimit := photoinifile.ReadString('tablename', 'tbllimit', '');
        tblArea := photoinifile.ReadString('tablename', 'tblArea', '');
        tblCutType := photoinifile.ReadString('tablename', 'tblCutType', '');
        tblFeeType := photoinifile.ReadString('tablename', 'tblFeeType', '');
        tblSysKey := photoinifile.ReadString('tablename', 'tblSysKey', '');
        tblCard := photoinifile.ReadString('tablename', 'tblCard', '');

        custId := photoinifile.ReadString('fieldname', 'custId', '');
        stuempNo := photoinifile.ReadString('fieldname', 'stuempNo', '');
        custName := photoinifile.ReadString('fieldname', 'custName', '');
        custType := photoinifile.ReadString('fieldname', 'custType', '');
        custState := photoinifile.ReadString('fieldname', 'custState', '');
        custArea := photoinifile.ReadString('fieldname', 'custArea', '');
        custSex := photoinifile.ReadString('fieldname', 'custSex', '');
        custcardId := photoinifile.ReadString('fieldname', 'custcardId', '');
        custDeptNo := photoinifile.ReadString('fieldname', 'custDeptNo', '');
        custSpecNo := photoinifile.ReadString('fieldname', 'custSpecNo', '');
        custRegTime := photoinifile.ReadString('fieldname', 'custRegTime', '');
        custFeeType := photoinifile.ReadString('fieldname', 'custFeeType', '');
        classNo := photoinifile.ReadString('fieldname', 'classNo', '');
        batchNo := photoinifile.ReadString('fieldname', 'batchNo', '');
        extField1 := photoinifile.ReadString('fieldname', 'extField1', '');
        extField2 := photoinifile.ReadString('fieldname', 'extField2', '');

        pPhoto := photoinifile.ReadString('fieldname', 'pPhoto', '');
        PMinPhoto := photoinifile.ReadString('fieldname', 'pMinPhoto', '');
        pIfCard := photoinifile.ReadString('fieldname', 'pIfCard', '');
        pCardDate := photoinifile.ReadString('fieldname', 'pCardDate', '');
        pCardTime := photoinifile.ReadString('fieldname', 'pCardTime', '');
        pPhotoDate := photoinifile.ReadString('fieldname', 'pPhotoDate', '');
        pPhotoTime := photoinifile.ReadString('fieldname', 'pPhotoTime', '');
        pPhotoDTime := photoinifile.ReadString('fieldname', 'pPhotoDTime', '');
        res_1 := photoinifile.ReadString('fieldname', 'res_1', '');
        res_2 := photoinifile.ReadString('fieldname', 'res_2', '');
        res_3 := photoinifile.ReadString('fieldname', 'res_3', '');

        lmtOperCode := photoinifile.ReadString('fieldname', 'lmtOperCode', '');
        lmtOperName := photoinifile.ReadString('fieldname', 'lmtOperName', '');
        lmtBeginDate := photoinifile.ReadString('fieldname', 'lmtBeginDate', '');
        lmtEndDate := photoinifile.ReadString('fieldname', 'lmtEndDate', '');
        lmtpwd := photoinifile.ReadString('fieldname', 'lmtpwd', '');
        lmtLimit := photoinifile.ReadString('fieldname', 'lmtLimit', '');
        lmtEnabled := photoinifile.ReadString('fieldname', 'lmtEnabled', '');

        deptCode := photoinifile.ReadString('fieldname', 'deptCode', '');
        deptName := photoinifile.ReadString('fieldname', 'deptName', '');
        deptParent := photoinifile.ReadString('fieldname', 'deptParent', '');
        deptLevel := photoinifile.ReadString('fieldname', 'deptLevel', '');

        specCode := photoinifile.ReadString('fieldname', 'specCode', '');
        specName := photoinifile.ReadString('fieldname', 'specName', '');

        dictNo := photoinifile.ReadString('fieldname', 'dictNo', '');
        dictValue := photoinifile.ReadString('fieldname', 'dictValue', '');
        dictCaption := photoinifile.ReadString('fieldname', 'dictCaption', '');

        areaNo := photoinifile.ReadString('fieldname', 'areaNo', '');
        areaName := photoinifile.ReadString('fieldname', 'areaName', '');
        areaFather := photoinifile.ReadString('fieldname', 'areaFather', '');

        typeName := photoinifile.ReadString('fieldname', 'typeName', '');
        typeNo := photoinifile.ReadString('fieldname', 'typeNo', '');

        feeFeeType := photoinifile.ReadString('fieldname', 'feeFeeType', '');
        feeFeeName := photoinifile.ReadString('fieldname', 'feeFeeName', '');

        keyCode := photoinifile.ReadString('fieldname', 'keyCode', '');
        keyName := photoinifile.ReadString('fieldname', 'keyName', '');
        keyValue := photoinifile.ReadString('fieldname', 'keyValue', '');
        keyMaxValue := photoinifile.ReadString('fieldname', 'keyMaxValue', '');
        keyCustId := photoinifile.ReadString('fieldname', 'keyCustId', '');

        cardCardId := photoinifile.ReadString('fieldname', 'cardCardId', '');
        cardStateId := photoinifile.ReadString('fieldname', 'cardStateId', '');
        cardCustId := photoinifile.ReadString('fieldname', 'cardCustId', '');

        useRemoteSoft := photoinifile.ReadBool('photo_config', 'remotecapture', True);

        photopath := photoinifile.ReadString('photo_config', 'photopath', '');
        photopre := photoinifile.ReadString('photo_config', 'photopre', '');
        diskpath := photoinifile.ReadString('photo_config', 'diskpath', '');

        rotate := photoinifile.ReadBool('photo_config', 'rotate', True);
        angle := photoinifile.ReadInteger('photo_config', 'angle', 0);

        minWidth := photoinifile.ReadInteger('photo_config', 'width', 0);
        minHeight := photoinifile.ReadInteger('photo_config', 'height', 0);
        if (minWidth / minHeight) <> 0.75 then
            minHeight := Round(minWidth * 4 / 3 + 1);
        pageOrien := photoinifile.ReadString('photo_config', 'orientation', 'P');

        ve_visible := photoinifile.ReadBool('photoviewbox', 'visible', False);
        if ve_visible = False then
            Exit;
        veL_top := photoinifile.ReadInteger('photoviewbox', 'lneL_top', 0);
        veL_left := photoinifile.ReadInteger('photoviewbox', 'lneL_left', 0);
        veL_height := photoinifile.ReadInteger('photoviewbox', 'lneL_height', 0);

        veR_top := photoinifile.ReadInteger('photoviewbox', 'lneR_top', 0);
        veR_left := photoinifile.ReadInteger('photoviewbox', 'lneR_left', 0);
        veR_height := photoinifile.ReadInteger('photoviewbox', 'lneR_height', 0);

        veT_top := photoinifile.ReadInteger('photoviewbox', 'lneT_top', 0);
        veT_left := photoinifile.ReadInteger('photoviewbox', 'lneT_left', 0);
        veT_width := photoinifile.ReadInteger('photoviewbox', 'lneT_width', 0);

        veB_top := photoinifile.ReadInteger('photoviewbox', 'lneB_top', 0);
        veB_left := photoinifile.ReadInteger('photoviewbox', 'lneB_left', 0);
        veB_width := photoinifile.ReadInteger('photoviewbox', 'lneB_width', 0);

        veA_top := photoinifile.ReadInteger('photoviewbox', 'lneA_top', 0);
        veA_left := photoinifile.ReadInteger('photoviewbox', 'lneA_left', 0);
        veA_width := photoinifile.ReadInteger('photoviewbox', 'lneA_width', 0);

        dburl := DecryptString(dbconfig.readstring('database', 'dbServer', '127.0.0.2:1521:yktdb'), CryptKey);
        dbUid := DecryptString(dbconfig.readstring('database', 'dbUser', 'ykt'), CryptKey);
        dbPwd := DecryptString(dbconfig.readstring('database', 'dbPass', 'password'), CryptKey);
    finally
        photoinifile.Destroy;
        dbconfig.Destroy;
    end;
end;

{-------------------------------------------------------------------------------
  ������:    AddData�������б�����������
  ����:      cbb:TComboBox;sqlstr:string
  ����ֵ:    ��
-------------------------------------------------------------------------------}

procedure AddData(cbb: TComboBox; sqlstr: string);
var
    qryExecSQL: TOraQuery;
begin
    qryExecSQL := nil; //frmdm.qryQuery;
    try
        qryExecSQL := TOraQuery.Create(Application.MainForm);
        qryExecSQL.Connection := frmdm.conn;
        //qryExecSQL.LockType := ltUnspecified;
        cbb.Items.Clear;
        cbb.Items.Add('');
        qryExecSQL.Close;
        qryExecSQL.sql.Clear;
        qryExecSQL.SQL.Add(sqlstr);
        qryExecSQL.Prepared;
        qryExecSQL.Open;
        if not qryExecSQL.IsEmpty then begin
            qryExecSQL.First;
            while not qryExecSQL.Eof do begin
                cbb.Items.Add(qryExecSQL.Fields[1].Text + '-' + qryexecSql.Fields[0].Text);
                qryExecSQL.Next;
            end;
            //cbb.Sorted := True;
        end;
    finally
        qryExecSQL.Destroy;
    end;
end;

{-------------------------------------------------------------------------------
  ������:    subString
  ����:      ssname:string;str:string;posi:string�ַ������ָ��ַ�������ȡ����
  ����ֵ:    string
-------------------------------------------------------------------------------}

function subString(ssname: string; str: string; posi: string): string;
begin
    if LowerCase(posi) = 'l' then
        Result := Copy(ssname, 0, Pos(str, ssname) - 1);
    if LowerCase(posi) = 'r' then
        Result := Copy(ssname, Pos(str, ssname) + 1, Length(ssname));
end;

{-------------------------------------------------------------------------------
  ������:    getDeptName���ݲ��ű��뷵�ز�������
  ����:      sDeptCode:string
  ����ֵ:    string
-------------------------------------------------------------------------------}

function getDeptName(sDeptCode: string): string;
var
    sqlstr: string;
begin
    sqlstr := 'select ' + deptname + ' from ' + tblDept + ' where ' + deptcode + '=' + QuotedStr(sDeptCode);
    Result := sqlExec(sqlstr, deptname);
end;

{-------------------------------------------------------------------------------
  ������:    getSName����רҵ���뷵��רҵ����
  ����:      ssCode:string
  ����ֵ:    string
-------------------------------------------------------------------------------}

function getSName(ssCode: string): string;
var
    sqlstr: string;
begin
    sqlstr := 'select ' + specName + ' from ' + tblSpec + ' where ' + specCode + '=' + QuotedStr(ssCode);
    Result := sqlExec(sqlstr, specName);
end;

{-------------------------------------------------------------------------------
  ������:    sqlExec���ݴ��������ص����ƣ������ء��������ĺ����޸�Ϊ���ô�
  ����:      sqlstr:string;rname:string
  ����ֵ:    string
-------------------------------------------------------------------------------}

function sqlExec(sqlstr: string; rname: string): string;
var
    tempQuery: TOraQuery;
begin
    tempQuery := nil;
    try
        tempQuery := TOraQuery.Create(nil);
        tempQuery.Connection := frmDM.conn;
        tempQuery.Close;
        tempQuery.SQL.Clear;
        tempQuery.SQL.Add(sqlstr);
        tempQuery.Open;
        if not tempQuery.IsEmpty then
            Result := tempQuery.fieldbyname(rname).AsString
        else
            Result := '';
    finally
        tempQuery.Destroy;
    end;
end;
{-------------------------------------------------------------------------------
  ������:    getAreaName����������ȡ����������
  ����:      areaNo:string
  ����ֵ:    String
-------------------------------------------------------------------------------}

function getAreaName(sareaNo: string): string;
var
    sqlstr: string;
begin
    sqlstr := 'select ' + areaName + ' from ' + tblArea + ' where 1=1 and ';
    sqlstr := sqlstr + areaNo + '=' + QuotedStr(sareaNo);
    Result := sqlExec(sqlstr, areaName);
end;

{-------------------------------------------------------------------------------
  ������:    getStatesNameȡ��״̬����
  ����:      StateNo:string
  ����ֵ:    String
-------------------------------------------------------------------------------}

function getStatesName(StateNo: string): string;
var
    sqlstr: string;
begin
    sqlstr := 'select ' + dictCaption + ' from ' + tblDict + ' where ' + dictNo + '=9 and ';
    sqlstr := sqlstr + dictValue + '=' + QuotedStr(StateNo);
    Result := sqlExec(sqlstr, dictCaption);
end;

{-------------------------------------------------------------------------------
  ������:    getTypeNameȡ���������
  ����:      typeNo:string
  ����ֵ:    String
-------------------------------------------------------------------------------}

function getTypeName(stypeNo: string): string;
var
    sqlstr: string;
begin
    sqlstr := 'select ' + typeName + ' from ' + tblCutType + ' where ' + typeNo + '=' + stypeNo;
    Result := sqlExec(sqlstr, typeName);
end;

{-------------------------------------------------------------------------------
  ������:    getTypeNameȡ�ÿ���
  ����:      typeNo:string
  ����ֵ:    String
-------------------------------------------------------------------------------}

function getCardNo(custId: string): string;
var
    sqlstr: string;
begin
    sqlstr := 'select ' + cardCardId + ' from ' + tblCard + ' where ' + cardStateId;
    sqlstr := sqlstr + ' in (' + #39 + '1' + #39 + ') and ' + cardCustId + '=' + custId;
    Result := sqlExec(sqlstr, cardCardId);
end;

function queryBaseInfoSql(sstuempNo: string; sareaId: string; scustId: string): string;
var
    sqlStr: string;
begin
    sqlStr := 'select ' + custId + ',' + stuempNo + ',' + custName + ',' + custType + ',' + custState;
    sqlStr := sqlStr + ',' + custArea + ',' + custCardId + ',' + custDeptNo + ',' + custSpecNo + ',' + classNo;
    sqlStr := sqlStr + ',' + custRegTime + ',' + custFeeType; //+','+extfield1+','+extfield2;
    sqlStr := sqlStr + ' from ' + tblCust + ' where 1>0';
    if Trim(sstuempNo) <> '' then
        sqlStr := sqlStr + ' and ' + stuempNo + '=' + #39 + sstuempNo + #39;
    if Trim(sareaId) <> '' then
        sqlStr := sqlStr + ' and ' + custArea + '=' + sareaId;
    if Trim(scustId) <> '' then
        sqlStr := sqlStr + ' and ' + custId + '=' + scustId;

    Result := sqlStr;
end;


function getPhotoInfo(scustId: string): TJPEGImage;
var
    sqlStr: string;
    qrySQL: TOraQuery;
    F3: TMemoryStream;
    Fjpg: TJpegImage;
    Fbmp: TBitmap;
    Buffer: Word;
begin
    sqlStr := 'select ' + pPhoto + ',' + pIfCard + ',' + pPhotoDate + ',' + pPhotoTime;
    sqlStr := sqlStr + ',' + pcardDate + ',' + pCardTime;
    sqlStr := sqlStr + ' from ' + tblPhoto + ' where ' + custId + '=' + scustId;
    qrySQL := nil;
    Fbmp := nil;
    //Fjpg:=nil;
    Result := nil;
    cpIfCard := '';
    cpCardDate := '';
    cpCardTime := '';
    F3 := TMemoryStream.Create;
    try
        qrySQL := TOraQuery.Create(nil);
        qrySQL.Connection := frmdm.conn;
        qrySQL.Close;
        qrySQL.SQL.Clear;
        qrySQL.SQL.Add(sqlStr);
        qrySQL.Prepared;
        qrySQL.Open;
        if not qrySQL.IsEmpty then begin
            qrySQL.First;
            cpIfCard := qrySQL.fieldbyname(pIfCard).AsString;
            cpCardDate := qrySQL.fieldbyname(pCardDate).AsString;
            cpCardTime := qrySQL.fieldbyname(pCardTime).AsString;
            TBlobField(qrySQL.fieldbyname(pPhoto)).savetoStream(F3);

            if (f3.Size = 0) then begin
                result := nil;
                Exit;
            end;
            F3.Position := 0;
            F3.ReadBuffer(Buffer, 2); //��ȡ�ļ���ǰ�����ֽڣ��ŵ�Buffer����
            try
                Fjpg := TJpegImage.create;

                if Buffer = $4D42 then {//���ǰ�����ֽ�����4D42[��λ����λ] (bmp)} begin
                    //ShowMessage('BMP'); //��ô�����BMP��ʽ���ļ�
                    Fbmp := TBitmap.Create;
                    F3.Position := 0;
                    if F3.Size > 10 then begin
                        Fbmp.LoadFromStream(F3);
                        Fjpg.Assign(Fbmp);
                        Result := Fjpg;
                    end;
                end
                else {//���ǰ�����ֽ�����D8FF[��λ����λ] (JPEG)} begin
                    //ShowMessage('JPEG'); //........һ�������治ע����
                    F3.Position := 0;
                    if F3.Size > 10 then begin
                        FJpg.LoadFromStream(F3);
                        Result := Fjpg;
                    end;
                end;
                //Fjpg := TJpegImage.Create;
            finally
                //if Fjpg<>nil then
                  //Fjpg.Free;
                if Fbmp <> nil then
                    Fbmp.Free;
                F3.Destroy;
            end;
        end;
    finally
        qrySQL.Destroy;
    end;
end;

{-------------------------------------------------------------------------------
  ������:    getJpgNoȡ����Ƭ�ı��
  ����:      jpgName:string
  ����ֵ:    string
-------------------------------------------------------------------------------}

function getJpgNo(jpgName: string): string;
begin
    result := subString(jpgName, '.', 'l');
end;

{-------------------------------------------------------------------------------
  ������:    ExportData
  ����:      SaveDialog1: TSaveDialog;DBGridEh1: TDBGridEh
  ����ֵ:    ��
-------------------------------------------------------------------------------}

function ExportData(SaveDialog1: TSaveDialog; DBGridEh1: TDBGridEh): Boolean;
var
    ExpClass: TDBGridEhExportClass;
    Ext: string;
begin
    Result := False;
    try
        begin
            SaveDialog1.FileName := '��������' + formatdatetime('yyyymmdd', date());
            DBGridEh1.Selection.SelectAll;
            if SaveDialog1.Execute then begin
                case SaveDialog1.FilterIndex of
                    4: begin
                            ExpClass := TDBGridEhExportAsText; Ext := 'txt'; end;
                    2: begin
                            ExpClass := TDBGridEhExportAsHTML; Ext := 'htm'; end;
                    3: begin
                            ExpClass := TDBGridEhExportAsRTF; Ext := 'rtf'; end;
                    1: begin
                            ExpClass := TDBGridEhExportAsXLS; Ext := 'xls'; end;
                else
                    ExpClass := nil; Ext := '';
                end;
                if ExpClass <> nil then begin
                    if UpperCase(Copy(SaveDialog1.FileName, Length(SaveDialog1.FileName) - 2, 3)) <> UpperCase(Ext) then
                        SaveDialog1.FileName := SaveDialog1.FileName + '.' + Ext;
                    SaveDBGridEhToExportFile(ExpClass, DBGridEh1, SaveDialog1.FileName, False);
                end;
                Result := True;
            end;
        end;
    except
        showmessage('����ʧ�ܣ�����...');
    end;
end;

{-------------------------------------------------------------------------------
  ������:    TfrmAddCustInfo.haveStuEmpNo����Ƿ����ѧ����
  ����:      ��
  ����ֵ:    Boolean���ڷ���true�����򷵻�false
-------------------------------------------------------------------------------}

function haveStuEmpNo(sstuEmpNo: string): Boolean;
var
    tmpQuery: TOraQuery;
    strSql: string;
begin
    strSql := queryBaseInfoSql(sstuEmpNo, '', '');
    tmpQuery := nil;
    Result := False;
    try
        tmpQuery := TOraQuery.Create(nil);
        tmpQuery.Connection := frmdm.conn;
        tmpQuery.Close;
        tmpQuery.SQL.Clear;
        tmpQuery.SQL.Add(strSql);
        tmpQuery.Open;
        if not tmpQuery.IsEmpty then
            Result := True;
    finally
        tmpQuery.Destroy;
    end;
end;

{-------------------------------------------------------------------------------
  ������:    qryOperSql
  ����:      soperCode:string;spwd:string
  ����ֵ:    string
-------------------------------------------------------------------------------}

function qryOperSql(soperCode: string; spwd: string): string;
var
    sqlStr: string;
begin
    sqlStr := 'select ' + lmtOperCode + ',' + lmtOperName + ',' + lmtBeginDate + ',' + lmtEndDate;
    sqlStr := sqlStr + ',' + lmtpwd + ',' + lmtLimit + ',' + lmtEnabled + ' from ' + tblLimit;
    sqlStr := sqlStr + ' where 1>0 ';
    if soperCode <> '' then
        sqlStr := sqlStr + ' and ' + lmtOperCode + '=' + #39 + sopercode + #39;
    if spwd <> '' then
        sqlStr := sqlStr + ' and ' + lmtpwd + '=' + #39 + DecryptString(spwd, CryptKey) + #39;

    Result := sqlStr;
end;

function judgelimit(oper: string; code: integer): boolean;
begin
    if copy(oper, code + 1, 1) = '1' then
        result := true
    else
        result := false;
end;

{-------------------------------------------------------------------------------
  ������:    insertPhotoData
  ����:      sCustId, sStuempNo: string
  ����ֵ:    ��
-------------------------------------------------------------------------------}

procedure insertPhotoData(sCustId, sStuempNo: string);
var
    photoQuery: TOraQuery;
    photoStr: string;
begin
    photoQuery := nil;
    try
        photoQuery := TOraQuery.Create(nil);
        photoQuery.Connection := frmdm.conn;
        //photoQuery.LockType := ltUnspecified;
        photoQuery.Close;
        photoQuery.SQL.Clear;
        photoQuery.SQL.Add('select count(*) as num from ' + tblPhoto + ' where ' + custId + '=' + sCustId);
        photoQuery.Open;
        if photoQuery.FieldByName('num').AsInteger = 0 then begin
            photoStr := 'insert into ' + tblPhoto + '(' + custId + ',' + stuempNo + ')values(';
            photoStr := photoStr + sCustId + ',';
            photoStr := photoStr + #39 + sStuempNo + #39 + ')';
            photoQuery.Close;
            photoQuery.SQL.Clear;
            photoQuery.SQL.Add(photoStr);
            photoQuery.ExecSQL;
        end;
    finally
        photoQuery.Free;
    end;
end;

{-------------------------------------------------------------------------------
  ������:    getMaxCustIdȡ�ͻ���
  ����:      ��
  ����ֵ:    Integer
-------------------------------------------------------------------------------}

function getMaxCustId: Integer;
var
    tmpQuery: TOraQuery;
    sqlStr: string;
    icustId: Integer;
begin
    sqlStr := 'select ' + keyValue + ' from ' + tblSysKey + ' where ' + keyCode + '=' + #39 + keyCustId + #39;
    tmpQuery := nil;
    icustId := 0;
    try
        tmpQuery := TOraQuery.Create(nil);
        tmpQuery.Connection := frmdm.conn;
        tmpQuery.Close;
        tmpQuery.SQL.Clear;
        tmpQuery.SQL.Add(sqlStr);
        tmpQuery.Open;
        if not tmpQuery.IsEmpty then
            icustId := tmpQuery.fieldbyname(keyValue).AsInteger;
        Result := icustId + 1;
    finally
        tmpQuery.Destroy;
    end;
end;

function addCustInfo(sstuempNo, sname, stype, sArea, scardId, sDept, sSpec, sFeeType: string): Boolean;
var
    custQuery: TOraQuery;
    keyQuery: TOraQuery;
    keyStr: string;
    custStr: string;
    icustId: Integer;
begin
    Result := False;
    icustId := getMaxCustId();
    custStr := 'insert into ' + tblCust + '(' + custId + ',' + stuempNo + ',' + custName + ',';
    custStr := custStr + custType + ',' + custState + ',' + custArea + ',' + custCardId + ',';
    custStr := custStr + custDeptNo + ',' + custSpecNo + ',' + custRegTime + ',' + feeFeeType + ')values(';
    custStr := custStr + inttostr(icustId) + ',';
    custStr := custStr + #39 + sstuempNo + #39 + ',';
    custStr := custStr + #39 + sname + #39 + ',';
    custStr := custStr + stype + ',';
    custStr := custStr + '1' + ',';
    custStr := custStr + sArea + ',';
    custStr := custStr + #39 + scardId + #39 + ',';
    custStr := custStr + #39 + sDept + #39 + ',';
    custStr := custStr + #39 + sSpec + #39 + ',';
    custStr := custStr + #39 + formatdatetime('yyyymmdd', now()) + #39 + ',';
    custStr := custStr + sFeeType + ')';
    keyStr := 'update ' + tblSysKey + ' set ' + keyValue + '=' + inttostr(icustId);
    keyStr := keyStr + ' where ' + keyCode + '=' + #39 + keyCustId + #39; ;
    custQuery := nil;
    //keyQuery := nil;
    try
        custQuery := TOraQuery.Create(nil);
        custQuery.Connection := frmdm.conn;

        custQuery.Close;
        custQuery.SQL.Clear;
        custQuery.SQL.Add(custStr);

        keyQuery := TOraQuery.Create(nil);
        keyQuery.Connection := frmdm.conn;

        keyQuery.Close;
        keyQuery.SQL.Clear;
        keyQuery.SQL.Add(keyStr);

        frmdm.conn.StartTransaction;
        try
            keyQuery.ExecSQL;
            custQuery.ExecSQL;
            frmdm.conn.Commit;
            Result := True;
        except

            frmdm.conn.Rollback;
            Result := False;
        end;
    finally
        custQuery.Destroy;
    end;
end;
{-------------------------------------------------------------------------------
  ������:    delFileBat����ɾ���ļ�
  ����:      filePath,fileName:string
  ����ֵ:    Boolean
-------------------------------------------------------------------------------}

procedure delFileBat(filePath, fileName: string);
var
    FileDir: string;
    FileStruct: TSHFileOpStruct;
begin
    try
        FileDir := filePath + '\' + filename;
        FileStruct.Wnd := 0;
        FileStruct.wFunc := FO_delete;
        FileStruct.pFrom := Pchar(FileDir + #0);
        FileStruct.fFlags := FOF_NOCONFIRMATION;
        FileStruct.pTo := '';
        if SHFileOperation(FileStruct) = 0 then
            Exit;
    except
    end;
end;


function getDbTime: string;
var
    tmpQuery: TOraQuery;
    sqlStr: string;
begin
    sqlStr := 'select to_char(current_timestamp,''YYYYMMDDHH24MISSFF'') dbtime from dual';

    try
        tmpQuery := TOraQuery.Create(nil);
        tmpQuery.Connection := frmdm.conn;
        tmpQuery.Close;
        tmpQuery.SQL.Clear;
        tmpQuery.SQL.Add(sqlStr);
        tmpQuery.Open;
        Result := tmpQuery.fieldbyname('dbtime').AsString;
    finally
        tmpQuery.Free;
    end;
end;

end.
