using {com.dkbmc.demo as dm} from '../../../../db/schema';

// 사용자 계정 서비스
service AccountService @(path: '/account') {
    entity Accounts                             as projection on dm.account;
    entity AccountTrainingContentChoiceAnswers  as projection on dm.account_training_content_choice_answer;
    entity AccountTrainingContentSubjectAnswers as projection on dm.account_training_content_subject_answer;
}
