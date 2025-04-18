using {com.dkbmc.demo as dm} from '../../../../db/schema';

// 단원별 컨텐츠 사용자 입력 서비스
service ChapterContentUserInputService @(path: '/chapter-content-user-input') {
    @cds.persistence.name: 'com_dkbmc_demo_chapter_content_user_input'
    entity ChapterContentUserInputs as projection on dm.chapter_content_user_input;
}
