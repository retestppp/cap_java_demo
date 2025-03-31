using {com.dkbmc.demo as dm} from '../../../../db/schema';

// 관리자 계정 서비스
service AdminAccountService @(path: '/adminAccount') {
    entity AdminAccounts     as projection on dm.admin_account; // 관리자 계정 정보
    entity AdminAccountsList as projection on dm.admin_account; // 관리자 계정 정보 리스트 조회

    // 액션 정의

    // 현재 사용자의 계정 정보를 업데이트하는 이벤트 핸들러
    action AdminAccountInsert(account_id : String,
                              account_name : String,
                              account_type : String,
                              account_email : String,
                              account_phone : String,
                              use_yn : String)                        returns String;

    // 사용자의 계정 정보를 업데이트하는 이벤트 핸들러 객체를 받아서 처리 현재는 사용 안하고 있음
    action AdminAccountUpdate_entity(AdminAccounts : AdminAccounts)   returns String;

    // 현재 사용자의 계정 정보를 업데이트하는 이벤트 핸들러
    action AdminAccountUpdate(account_id : String,
                              account_name : String,
                              account_type : String,
                              account_email : String,
                              account_phone : String )               returns String;

    // 현재 사용자의 계정 정보를 업데이트하는 이벤트 핸들러
    action AdminAccountUpdateNoToken(account_idx : UUID,
                                     account_id : String,
                                     account_name : String,
                                     account_type : String,
                                     account_email : String,
                                     account_phone : String,
                                     use_yn : String)                 returns String;

    // 다수의 사용자 계정 정보를 삭제하는 이벤트 핸들러
    action bulkDeleteAdminAccount(adminAccounts : many UUID)          returns String;
    action bulkUpdateAdminAccount(adminAccounts : many AdminAccounts) returns String;
    // 로그인 액션 정의 추가
    action login(account_id : String, account_password : String)      returns String;
    // 엑세스 토큰 만료시 엓세스 토큰 재발급
    action refreshToken()                                             returns String;
    action logout()                                                   returns String;
    // 이메일 전송
    action sendEmail()                                                returns String;
    // 아이디 찾기 이메일보내기
    action findId(AdminAccounts : AdminAccounts)                      returns String;
    // 비밀번호 찾기 이메일보내기
    action findPwd(AdminAccounts : AdminAccounts)                     returns String;
}
