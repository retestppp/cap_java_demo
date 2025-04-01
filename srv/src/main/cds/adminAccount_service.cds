using { com.dkbmc.demo as dm } from '../../../../db/schema';

// 관리자 계정 서비스
service AdminAccountService @(path: '/adminAccount') {

    @cds.persistence.name: 'com_dkbmc_demo_admin_account'
    entity AdminAccounts as projection on dm.admin_account;

    // 액션 정의
    action AdminAccountInsert(
        account_id : String,
        account_name : String,
        account_type : String,
        account_email : String,
        account_phone : String,
        use_yn : String
    ) returns String;

    action AdminAccountUpdate_entity(input : AdminAccounts) returns String;

    action AdminAccountUpdate(
        account_id : String,
        account_name : String,
        account_type : String,
        account_email : String,
        account_phone : String
    ) returns String;

    action AdminAccountUpdateNoToken(
        account_idx : UUID,
        account_id : String,
        account_name : String,
        account_type : String,
        account_email : String,
        account_phone : String,
        use_yn : String
    ) returns String;

    action bulkDeleteAdminAccount(accountIds : many UUID) returns String;

    action bulkUpdateAdminAccount(admins : many AdminAccounts) returns String;

    action login(account_id : String, account_password : String) returns String;

    action refreshToken() returns String;
    action logout() returns String;

    action sendEmail() returns String;

    action findId(input : AdminAccounts) returns String;
    action findPwd(input : AdminAccounts) returns String;
}
