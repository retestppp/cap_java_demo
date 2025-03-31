using {com.dkbmc.demo as dm} from '../../../../db/schema';

// 교육 과정 및 단원 서비스
service CurriculumService @(path: '/curriculum') {
    entity CurCurriculums as projection on dm.curriculum
        order by curriculum_name asc;

    action bulkUpdateCurriculums(curriculums : many CurCurriculums) returns String;
    entity CurriculumChapters as projection on dm.curriculum_chapter;
    action bulkInsertCurriculumChapters(CurriculumChapters : many CurriculumChapters) returns String;
    action bulkDeleteCurriculums(curriculums : many UUID) returns String;

    // ✅ key 추가됨
    entity CurriculumChaptersTree {
        key chapter_pk        : UUID;
            curriculum_pk     : UUID;
            parent_chapter_pk : UUID;
            chapter_name      : String(200);
            chapter_level     : Integer;
            sort_order        : Integer;
            use_yn            : String(1);
            error_code        : Integer;
            message           : String(200);
            children          : Composition of many CurriculumChaptersTree
                                on children.parent_chapter_pk = chapter_pk;
    }

    action getCurriculumChaptersTree(curriculum_pk : UUID) returns many CurriculumChaptersTree;
    action insertCurriculumChapter(curriculum_pk : UUID,
                                   parent_chapter_pk : UUID,
                                   chapter_name : String,
                                   use_yn : String) returns String;

    action updateCurriculumChapter(chapter_pk : UUID,
                                   curriculum_pk : UUID,
                                   parent_chapter_pk : UUID,
                                   chapter_name : String,
                                   chapter_level : Integer,
                                   sort_order : Integer,
                                   use_yn : String) returns String;

    entity ChapterContents as projection on dm.chapter_content;
    entity CurTrainingContentsNoChoice as projection on dm.training_content;
    action bulkInsertChapterContents(chapter_pk : UUID, ChapterContent : many CurTrainingContents) returns String;
    entity CurTrainingContentChoices as projection on dm.training_content_choice;

    entity CurTrainingContents {
        key training_content_pk : UUID;
            training_domain_pk  : UUID;
            content_type_code   : String(50);
            content_name        : String(200);
            content             : LargeString;
            remark              : String(3000);
            sort_order          : Integer;
            use_yn              : String(1);
            create_user_pk      : UUID;
            create_datetime     : DateTime  @cds.on.insert: $now;
            update_user_pk      : UUID;
            update_datetime     : DateTime  @cds.on.insert: $now  @cds.on.update: $now;
            choices             : Composition of many CurTrainingContentChoices
                                      on choices.training_content_pk = training_content_pk;
            choice              : Association to CurTrainingContentChoices
                                      on choice.training_content_pk = training_content_pk;
    }

    action bulkInsertChapterContentsWithChoice(chapter_pk : UUID, ChapterContent : many CurTrainingContents) returns String;
    action getCurTrainingContents(chapter_pk : UUID) returns many CurTrainingContents;

    // ✅ key 추가됨
    view ViewCurCurriculums as
        select from dm.curriculum as c
        left join dm.common_code as cc
            on  c.curriculum_type_code = cc.code_cd
            and cc.group_code_cd       = 'CURRICULUM_TYPE'
        {
            key c.curriculum_pk,
                c.curriculum_name,
                c.use_yn,
                cc.code_cd,
                cc.code_name as curriculum_type_name
        }
        order by c.curriculum_name asc;
}
