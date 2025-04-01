using {com.dkbmc.demo as dm} from '../../../../db/schema';

// 교육 컨텐츠 서비스
service TrainingContentService @(path: '/training-content') {
    @cds.persistence.name: 'com_dkbmc_demo_training_content'
    entity TrainingContents       as projection on dm.training_content;
    @cds.persistence.name: 'com_dkbmc_demo_training_content_choice'
    entity TrainingContentChoices as projection on dm.training_content_choice;
}
