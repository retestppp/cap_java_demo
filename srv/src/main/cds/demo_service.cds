// using {com.dkbmc.demo as dm} from '../../../../db/schema';

// // 제품 정보 및 교육 과정 서비스
// service ProductService @(path: '/product') {
//   entity Products           as projection on dm.sf_product
//                                order by
//                                  sell_yn desc,
//                                  create_datetime desc;

//   entity ProCurriculums     as projection on dm.curriculum;
//   entity ProductCurriculums as projection on dm.product_curriculum;

//   view ViewProductsCurriculum as
//     select from dm.sf_product as p
//     inner join dm.product_curriculum as pc
//       on p.product_id = pc.product_id
//     left join dm.curriculum as c
//       on pc.curriculum_pk = c.curriculum_pk
//     left join dm.common_code as cc
//       on  p.sell_yn        = cc.code_cd
//       and cc.group_code_cd = 'SELL_YN'
//     left join dm.common_code as cc2
//       on  c.curriculum_type_code = cc2.code_cd
//       and cc2.group_code_cd      = 'CURRICULUM_TYPE'
//     {
//       p.product_id, // 필드에서 가져올 데이터 선택
//       p.product_name, // 필드에서 가져올 데이터 선택
//       c.curriculum_name, // 조인된 필드에서 가져올 데이터 선택
//       c.curriculum_pk, // 조인된 필드에서 가져올 데이터 선택
//       c.from_date, // 조인된 필드에서 가져올 데이터 선택
//       c.to_date, // 조인된 필드에서 가져올 데이터 선택
//       c.create_datetime, // 조인된 필드에서 가져올 데이터 선택
//       cc.code_name  as sell_yn_name, // 조인된 필드에서 가져올 데이터 선택
//       cc2.code_name as curriculum_type_name, // 조인된 필드에서 가져올 데이터 선택
//       c.use_yn, // 조인된 필드에서 가져올 데이터 선택
//       c.curriculum_type_code, // 조인된 필드에서 가져올 데이터 선택
//       case
//         when
//           c.use_yn = 'Y'
//         then
//           '사용중'
//         when
//           c.use_yn = 'N'
//         then
//           '사용안함'
//         else
//           '알수없음'
//       end           as use_yn_name : String // 조건에 따른 사용 상
//     }
//     order by
//       c.curriculum_name asc;

//   // 액션 정의
//   action bulkInsertCurriculums(product_id : UUID,
//                                curriculum : many ProCurriculums) returns String;
// }

// // 교육 과정 및 단원 서비스
// service CurriculumService @(path: '/curriculum') {
//   entity CurCurriculums            as projection on dm.curriculum
//                                       order by
//                                         curriculum_name asc;

//   entity CurriculumChapters        as projection on dm.curriculum_chapter;
//   action bulkInsertCurriculumChapters(CurriculumChapters : many CurriculumChapters) returns String;

//   // 추가된 트리 구조를 위한 뷰
//   entity CurriculumChaptersTree {
//     chapter_pk        : UUID;
//     curriculum_pk     : UUID;
//     parent_chapter_pk : UUID;
//     chapter_name      : String(200);
//     chapter_level     : Integer;
//     sort_order        : Integer;
//     use_yn            : String(1);
//     children          : Composition of many CurriculumChaptersTree
//                           on children.parent_chapter_pk = chapter_pk;
//   }

//   // POST http://localhost:4004/curriculum/getCurriculumChaptersTree
//   //   Type: application / json Accept : application / json
//   //   body{
//   //     "curriculum_pk" : "af87749a-fd77-4573-88ab-cbd652236671"
//   //   }

//   action getCurriculumChaptersTree(curriculum_pk : UUID)                            returns many CurriculumChaptersTree;
//   // 교육과정 챕터별 컨텐츠
//   entity ChapterContents           as projection on dm.chapter_content;
//   // 교육과정 챕터별 컨텐츠 사용자 입력
//   entity CurTrainingContents       as projection on dm.training_content;
//   entity CurTrainingContentChoices as projection on dm.training_content_choice;

//   // 교육과정 챕터별 컨텐츠 벌크 인서트
//   action bulkInsertChapterContents(chapter_pk : UUID,
//                                    ChapterContent : many CurTrainingContents)       returns String;


//   view ViewCurCurriculums as
//     select from dm.curriculum as c
//     left join dm.common_code as cc
//       on  c.curriculum_type_code = cc.code_cd
//       and cc.group_code_cd       = 'CURRICULUM_TYPE'
//     {
//       c.*,
//       cc.code_cd, // 조인된 필드에서 가져올 데이터 선택
//       cc.code_name as curriculum_type_name, // 조인된 필드에서 가져올 데이터 선택
//       case
//         when
//           c.use_yn = 'Y'
//         then
//           '사용중'
//         when
//           c.use_yn = 'N'
//         then
//           '사용안함'
//         else
//           '알수없음'
//       end          as use_yn_name : String // 조건에 따른 사용 상태
//     }
//     order by
//       c.curriculum_name asc;

// // view totalCount as select count( * ) as total from dm.curriculum;

// }

// // 교육 컨텐츠 서비스
// service TrainingContentService @(path: '/training-content') {
//   entity TrainingContents       as projection on dm.training_content;
//   entity TrainingContentChoices as projection on dm.training_content_choice;
// }

// // 관리자 계정 서비스
// service AdminAccountService @(path: '/account') {
//   entity AdminAccounts     as projection on dm.admin_account; // 관리자 계정 정보
//   entity AdminAccountsList as projection on dm.admin_account; // 관리자 계정 정보 리스트 조회

//   // 액션 정의

//   // 현재 사용자의 계정 정보를 업데이트하는 이벤트 핸들러
//   action AdminAccountInsert(account_id : String,
//                             account_name : String,
//                             account_type : String,
//                             account_email : String,
//                             account_phone : String,
//                             use_yn : String)                      returns String;

//   // 사용자의 계정 정보를 업데이트하는 이벤트 핸들러 객체를 받아서 처리 현재는 사용 안하고 있음
//   action AdminAccountUpdate_entity(AdminAccounts : AdminAccounts) returns String;

//   // 현재 사용자의 계정 정보를 업데이트하는 이벤트 핸들러
//   action AdminAccountUpdate(account_id : String,
//                             account_password : String,
//                             account_name : String,
//                             account_type : String,
//                             account_email : String,
//                             account_phone : String,
//                             new_account_password : String)        returns String;

//   // 현재 사용자의 계정 정보를 업데이트하는 이벤트 핸들러
//   action AdminAccountUpdateNoToken(account_idx : UUID,
//                                    account_id : String,
//                                    account_name : String,
//                                    account_type : String,
//                                    account_email : String,
//                                    account_phone : String,
//                                    use_yn : String)               returns String;
// }

// // 사용자 계정 서비스
// service AccountService @(path: '/account') {
//   entity Accounts                             as projection on dm.account;
//   entity AccountTrainingContentChoiceAnswers  as projection on dm.account_training_content_choice_answer;
//   entity AccountTrainingContentSubjectAnswers as projection on dm.account_training_content_subject_answer;
// }

// // 요구사항 수집 서비스
// service RequirementGatherService @(path: '/requirement-gather') {
//   entity RequirementGathers as projection on dm.requirement_gather;
// }

// // 단원별 컨텐츠 사용자 입력 서비스
// service ChapterContentUserInputService @(path: '/chapter-content-user-input') {
//   entity ChapterContentUserInputs as projection on dm.chapter_content_user_input;
// }
