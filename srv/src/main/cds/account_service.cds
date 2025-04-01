using { com.dkbmc.demo as dm } from '../../../../db/schema';

// 사용자 계정 서비스
service AccountService @(path: '/account') {

    @cds.persistence.name: 'com_dkbmc_demo_account'
    entity Accounts as projection on dm.account;

    @cds.persistence.name: 'com_dkbmc_demo_account_training_content_choice_answer'
    entity AccountTrainingContentChoiceAnswers as projection on dm.account_training_content_choice_answer;

    @cds.persistence.name: 'com_dkbmc_demo_account_training_content_subject_answer'
    entity AccountTrainingContentSubjectAnswers as projection on dm.account_training_content_subject_answer;

}
