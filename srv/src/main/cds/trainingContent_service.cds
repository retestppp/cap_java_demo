using {com.dkbmc.demo as dm} from '../db/schema';

// 교육 컨텐츠 서비스
service TrainingContentService @(path: '/training-content') {
    entity TrainingContents       as projection on dm.training_content;
    entity TrainingContentChoices as projection on dm.training_content_choice;
}
