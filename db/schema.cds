namespace com.dkbmc.demo;

using {
    cuid,
    managed
} from '@sap/cds/common';

entity attachment : cuid, managed {
    @Core.MediaType  : mediatype
    content          : LargeBinary @stream;

    @Core.IsMediaType: true
    mediatype        : String;
    name             : String;
    size             : Integer; // byte
    fileLastModified : DateTime
}


// 신규 프로젝트 관련 추가
//
// 1. 제품 정보 엔티티
entity sf_product {
    key product_id      : UUID; // 제품 ID
        product_name    : String(200)   @mandatory; // 제품 이름
        sell_yn         : String(1)     @mandatory; // 판매 여부 (y/n)
        create_user_pk  : UUID not null @assert.notEmpty: true; // 생성 사용자 기본 키
        create_datetime : DateTime      @cds.on.insert  : $now; // 생성 일시
        update_user_pk  : UUID not null @assert.notEmpty: true; // 수정 사용자 기본 키
        update_datetime : DateTime      @cds.on.insert  : $now  @cds.on.update: $now; // 수정 일시
}

// 2. 교육 과정 엔티티
entity curriculum {
    key curriculum_pk        : UUID          @default.uuid; // 교육 과정 기본 키
        curriculum_name      : String(200)   @mandatory; // 교육 과정 이름
        curriculum_type_code : String(200)   @mandatory; // 교육 과정 유형 코드
        from_date            : String(200); // 시작 날짜
        to_date              : String(200); // 종료 날짜
        use_yn               : String(1)     @mandatory; // 사용 여부
        create_user_pk       : UUID not null @assert.notEmpty: true; // 생성 사용자 기본 키
        create_datetime      : DateTime      @cds.on.insert  : $now; // 생성 일시
        update_user_pk       : UUID not null @assert.notEmpty: true; // 수정 사용자 기본 키
        update_datetime      : DateTime      @cds.on.insert  : $now  @cds.on.update: $now; // 수정 일시
}


// 3. 제품과 교육 과정 간의 관계 엔티티
// entity product_curriculum {
//     key product_id    : Association to sf_product; // 제품 ID
//     key curriculum_pk : Association to curriculum; // 교육 과정 기본 키
// }

// 3.제품과 교육 과정 간의 관계 엔티티 관계삭제
entity product_curriculum {
    key product_id    : UUID; // 제품 ID
    key curriculum_pk : UUID; // 교육 과정 기본 키
}

// // 4. 교육 과정별 단원 엔티티
// entity curriculum_chapter {
//     key chapter_pk        : Integer; // 단원 기본 키
//         curriculum_pk     : Association to curriculum; // 교육 과정 기본 키
//         parent_chapter_pk : Association to curriculum_chapter; // 부모 단원 기본 키
//         chapter_name      : String(200); // 단원 이름
//         chapter_level     : Integer; // 단원 레벨
//         sort_order        : Integer; // 정렬 순서
//         use_yn            : String(1); // 사용 여부
//         create_user_pk    : Integer; // 생성 사용자 기본 키
//         create_datetime   : DateTime; // 생성 일시
//         update_user_pk    : Integer; // 수정 사용자 기본 키
//         update_datetime   : DateTime; // 수정 일시
// }

// 4. 교육 과정별 단원 엔티티 관계삭제
entity curriculum_chapter {
    key chapter_pk        : UUID; // 단원 기본 키
        curriculum_pk     : UUID; // 교육 과정 기본 키
        parent_chapter_pk : UUID; // 부모 단원 기본 키
        chapter_name      : String(200); // 단원 이름
        chapter_level     : Integer; // 단원 레벨
        sort_order        : Integer; // 정렬 순서
        use_yn            : String(1); // 사용 여부
        create_user_pk    : UUID not null @assert.notEmpty: true; // 생성 사용자 기본 키
        create_datetime   : DateTime      @cds.on.insert  : $now; // 생성 일시
        update_user_pk    : UUID not null @assert.notEmpty: true; // 수정 사용자 기본 키
        update_datetime   : DateTime      @cds.on.insert  : $now  @cds.on.update: $now; // 수정 일시
}

// // 5. 단원별 컨텐츠 엔티티
// entity chapter_content {
//     key chapter_pk      : Association to curriculum_chapter; // 단원 기본 키
//     key content_pk      : Association to training_content; // 컨텐츠 기본 키
//         create_user_pk  : Integer; // 생성 사용자 기본 키
//         create_datetime : DateTime; // 생성 일시
//         update_user_pk  : Integer; // 수정 사용자 기본 키
//         update_datetime : DateTime; // 수정 일시
// }

// 5. 단원별 컨텐츠 엔티티 관계 삭제
entity chapter_content {
    key chapter_pk          : UUID; // 단원 기본 키
    key training_content_pk : UUID; // 컨텐츠 기본 키
        create_user_pk      : UUID not null @assert.notEmpty: true; // 생성 사용자 기본 키
        create_datetime     : DateTime      @cds.on.insert  : $now; // 생성 일시
        update_user_pk      : UUID not null @assert.notEmpty: true; // 수정 사용자 기본 키
        update_datetime     : DateTime      @cds.on.insert  : $now  @cds.on.update: $now; // 수정 일시
}

// 6. 교육 컨텐츠 엔티티
entity training_content {
    key training_content_pk : UUID; // 교육 컨텐츠 기본 키
        content_type_code   : String(50); // 컨텐츠 유형 코드
        content_name        : String(200); // 컨텐츠 이름
        content             : LargeString; // 컨텐츠 본문
        remark              : String(3000); // 비고
        sort_order          : Integer; // 정렬 순서
        use_yn              : String(1); // 사용 여부
        create_user_pk      : UUID not null @assert.notEmpty: true; // 생성 사용자 기본 키
        create_datetime     : DateTime      @cds.on.insert  : $now; // 생성 일시
        update_user_pk      : UUID not null @assert.notEmpty: true; // 수정 사용자 기본 키
        update_datetime     : DateTime      @cds.on.insert  : $now  @cds.on.update: $now; // 수정 일시
}

// // 7. 교육 컨텐츠 선택 보기 엔티티
// entity training_content_choice {
//     key choice_pk           : Integer; // 선택 기본 키
//         training_content_pk : Association to training_content; // 교육 컨텐츠 기본 키
//         choice_content      : String(200); // 선택 내용
//         sort_order          : Integer; // 정렬 순서
//         answer_yn           : String(1); // 답 여부
//         use_yn              : String(1); // 사용 여부
//         create_user_pk      : Integer; // 생성 사용자 기본 키
//         create_datetime     : DateTime; // 생성 일시
//         update_user_pk      : Integer; // 수정 사용자 기본 키
//         update_datetime     : DateTime; // 수정 일시
// }

// 7. 교육 컨텐츠 선택 보기 엔티티 관계 삭제
entity training_content_choice {
    key choice_pk           : UUID; // 선택 기본 키
        training_content_pk : UUID; // 교육 컨텐츠 기본 키
        choice_content      : String(200); // 선택 내용
        sort_order          : Integer; // 정렬 순서
        answer_yn           : String(1); // 답 여부
        use_yn              : String(1); // 사용 여부
        create_user_pk      : UUID not null @assert.notEmpty: true; // 생성 사용자 기본 키
        create_datetime     : DateTime      @cds.on.insert  : $now; // 생성 일시
        update_user_pk      : UUID not null @assert.notEmpty: true; // 수정 사용자 기본 키
        update_datetime     : DateTime      @cds.on.insert  : $now  @cds.on.update: $now; // 수정 일시
}

// 8. 일반 사용자 계정 엔티티
entity account {
    key account_number : String(50); // 계정 번호 (휴대전화번호로 관리)
}


// 8. 사용자 계정 엔티티
entity admin_account {
    key account_idx      : UUID; // 계정 번호 기본 키, 자동 증가
        account_id       : String(200); // 계정 아이디
        account_password : String(200); // 계정 비밀번호
        account_name     : String(200); // 계정 이름
        account_type     : String(50); // 계정 유형
        account_email    : String(200); // 계정 이메일
        account_phone    : String(200); // 계정 연락처
        access_token     : LargeString; // 접근 토큰
        refresh_token    : LargeString; // 갱신 토큰
        use_yn           : String(1); // 사용 여부
        init_login_yn    : String(1); // 최초로그인 여부
        create_user_pk   : UUID not null @assert.notEmpty: true; // 생성 사용자 기본 키
        create_datetime  : DateTime      @cds.on.insert  : $now; // 생성 일시
        update_user_pk   : UUID not null @assert.notEmpty: true; // 수정 사용자 기본 키
        update_datetime  : DateTime      @cds.on.insert  : $now  @cds.on.update: $now; // 수정 일시
        expire_datetime  : String(200); // 만료 일시
}

// create_user_pk   : UUID not null @assert.notEmpty: true; // 생성 사용자 기본 키
// create_datetime  : DateTime      @cds.on.insert  : $now; // 생성 일시
// update_user_pk   : UUID not null @assert.notEmpty: true; // 수정 사용자 기본 키
// update_datetime  : DateTime      @cds.on.insert  : $now  @cds.on.update: $now; // 수정 일시

// // 9. 단원별 요구사항 수집 엔티티
// entity requirement_gather {
//     key requirement_pk          : Integer; // 요구사항 기본 키
//         user_input_pk           : Association to chapter_content_user_input; // 사용자 입력 기본 키
//         large_category          : String(200); // 대분류
//         middle_category         : String(200); // 중분류
//         small_category          : String(200); // 소분류
//         requirement_title       : String(200); // 요구사항 제목
//         requirement_description : String(3000); // 요구사항 설명
//         sort_order              : Integer; // 정렬 순서
//         create_user_id          : String(50); // 생성 사용자 ID
//         create_date             : DateTime; // 생성 일시
//         update_user_id          : String(50); // 수정 사용자 ID
//         update_date             : DateTime; // 수정 일시
// }

// 9. 단원별 요구사항 수집 엔티티 관계 삭제
entity requirement_gather {
    key requirement_pk          : UUID; // 요구사항 기본 키
        user_input_pk           : UUID; // 사용자 입력 기본 키
        large_category          : String(200); // 대분류
        middle_category         : String(200); // 중분류
        small_category          : String(200); // 소분류
        requirement_title       : String(200); // 요구사항 제목
        requirement_description : String(3000); // 요구사항 설명
        sort_order              : Integer; // 정렬 순서
        create_user_pk          : UUID not null @assert.notEmpty: true; // 생성 사용자 기본 키
        create_datetime         : DateTime      @cds.on.insert  : $now; // 생성 일시
        update_user_pk          : UUID not null @assert.notEmpty: true; // 수정 사용자 기본 키
        update_datetime         : DateTime      @cds.on.insert  : $now  @cds.on.update: $now; // 수정 일시
}

// // 10. 단원별 컨텐츠 사용자 입력 엔티티
// entity chapter_content_user_input {
//     key user_input_pk        : Integer; // 사용자 입력 기본 키
//         chapter_pk           : Association to curriculum_chapter; // 단원 기본 키
//         training_content_pk  : Association to training_content; // 교육 컨텐츠 기본 키
//         user_input_type_code : String(50); // 사용자 입력 유형 코드
//         sort_order           : Integer; // 정렬 순서
// }

// 10. 단원별 컨텐츠 사용자 입력 엔티티 관계 삭제
entity chapter_content_user_input {
    key user_input_pk        : UUID; // 사용자 입력 기본 키
        chapter_pk           : UUID; // 단원 기본 키
        training_content_pk  : UUID; // 교육 컨텐츠 기본 키
        user_input_type_code : String(50); // 사용자 입력 유형 코드
        sort_order           : Integer; // 정렬 순서
}

// // 11. 사용자가 입력한 객관식 문제에 대한 답 엔티티
// entity account_training_content_choice_answer {
//     key answer_pk             : Integer; // 답 기본 키
//         chapter_pk            : Association to curriculum_chapter; // 단원 기본 키
//         training_content_pk   : Association to training_content; // 교육 컨텐츠 기본 키
//         account_number        : Association to account; // 계정 번호
//         create_account_number : String(50); // 생성 계정 번호
//         create_datetime       : DateTime; // 생성 일시
//         update_account_number : String(50); // 수정 계정 번호
//         update_datetime       : DateTime; // 수정 일시
//         choice_pk             : Association to training_content_choice; // 선택 기본 키
// }

// 11. 사용자가 입력한 객관식 문제에 대한 답 엔티티 관계 삭제
entity account_training_content_choice_answer {
    key answer_pk             : UUID; // 답 기본 키
        chapter_pk            : UUID; // 단원 기본 키
        training_content_pk   : UUID; // 교육 컨텐츠 기본 키
        account_number        : String(50); // 계정 번호
        create_account_number : String(50); // 생성 계정 번호
        create_datetime       : DateTime; // 생성 일시
        update_account_number : String(50); // 수정 계정 번호
        update_datetime       : DateTime; // 수정 일시
        choice_pk             : UUID; // 선택 기본 키
}

// // 12. 사용자가 입력한 주관식 문제에 대한 답 엔티티
// entity account_training_content_subject_answer {
//     key answer_pk             : Integer; // 답 기본 키
//         chapter_pk            : Association to curriculum_chapter; // 단원 기본 키
//         training_content_pk   : Association to training_content; // 교육 컨텐츠 기본 키
//         account_number        : Association to account; // 계정 번호
//         create_account_number : String(50); // 생성 계정 번호
//         create_datetime       : DateTime; // 생성 일시
//         update_account_number : String(50); // 수정 계정 번호
//         update_datetime       : DateTime; // 수정 일시
// }

// 12. 사용자가 입력한 주관식 문제에 대한 답 엔티티 관계 삭제
entity account_training_content_subject_answer {
    key answer_pk             : UUID; // 답 기본 키
        chapter_pk            : UUID; // 단원 기본 키
        training_content_pk   : UUID; // 교육 컨텐츠 기본 키
        account_number        : String(50); // 계정 번호
        create_account_number : String(50); // 생성 계정 번호
        create_datetime       : DateTime; // 생성 일시
        update_account_number : String(50); // 수정 계정 번호
        update_datetime       : DateTime; // 수정 일시
}


// 13. 공통 코드 엔티티
entity common_code {
    key code_idx        : UUID; // 코드 ID
        group_code_cd   : String(50); // 코드 유형
        code_name       : String(200); // 코드 이름
        code_cd         : String(200); // 코드 값
        sort_order      : Integer; // 정렬 순서
        use_yn          : String(1); // 사용 여부
        desc            : String(200); // 코드 설명
        create_user_pk  : UUID not null @assert.notEmpty: true; // 생성 사용자 기본 키
        create_datetime : DateTime      @cds.on.insert  : $now; // 생성 일시
        update_user_pk  : UUID not null @assert.notEmpty: true; // 수정 사용자 기본 키
        update_datetime : DateTime      @cds.on.insert  : $now  @cds.on.update: $now; // 수정 일시
}

//  14. test
entity media {
        // key id              : UUID;
    key id              : Integer;

        @Core.MediaType  : mediaType
        content         : LargeBinary;

        @Core.IsMediaType: true
        mediaType       : String;
        fileName        : String;
        applicationName : String;
        originFileName  : String; // 저장파일명
        fileSize        : Integer;
        fileUrl         : String; // 디렉토리 URL
}
// //  14. test
// entity media {

//     key id              : UUID;

//         @Core.MediaType  : mediaType
//         content         : LargeBinary;

//         @Core.IsMediaType: true
//         mediaType       : String;
//         originFileName  : String; // 원본파일명
//         fileName        : String; // 저장파일명
//         fileSize        : Integer;
//         fileUrl         : String; // 디렉토리 URL

//         uploadDateTime  : DateTime @cds.on.insert: $now; // 파일 업로드 날짜 및 시간
//         lastAccessTime  : DateTime; // 마지막 접근 날짜 및 시간
//         uploadedBy      : UUID; // 파일을 업로드한 사용자의 ID
//         fileStatus      : String(10); // 파일의 상태 (예: active, deleted, archived 등)
//         fileDescription : String(500); // 파일에 대한 설명 또는 주석
//         fileVersion     : Integer default 1; // 파일의 버전 (버전 관리 시 사용)
//         fileExtension   : String(10); // 파일 확장자
//         fileMimeType    : String(100); // 파일의 MIME 유형
//         fileCategory    : String(100); // 파일의 카테고리
//         fileSubCategory : String(100); // 파일의 하위 카테고리
//         fileTags        : String(500); // 파일에 대한 태그
//         fileOwner       : UUID; // 파일 소유자
//         fileGroup       : UUID; // 파일 그룹
//         filePermission  : String(10); // 파일 권한 (예: public, private, protected 등)
//         fileLocation    : String(500); // 파일 저장 위치
// }
