using {com.dkbmc.demo as dm} from '../../../../db/schema';

// 제품 정보 및 교육 과정 서비스
service ProductService @(path: '/product') {
    entity Products as projection on dm.sf_product
        order by sell_yn desc, create_datetime desc;

    entity ProCurriculums     as projection on dm.curriculum;
    entity ProductCurriculums as projection on dm.product_curriculum;

    // ✅ key 추가됨
    view ViewProductsCurriculum as
        select from dm.sf_product as p
        inner join dm.product_curriculum as pc
            on p.product_id = pc.product_id
        left join dm.curriculum as c
            on pc.curriculum_pk = c.curriculum_pk
        left join dm.common_code as cc
            on  p.sell_yn        = cc.code_cd
            and cc.group_code_cd = 'SELL_YN'
        left join dm.common_code as cc2
            on  c.curriculum_type_code = cc2.code_cd
            and cc2.group_code_cd      = 'CURRICULUM_TYPE'
        {
            key p.product_id,
            key c.curriculum_pk,
                p.product_name,
                c.curriculum_name,
                c.from_date,
                c.to_date,
                c.create_datetime,
                cc.code_name  as sell_yn_name,
                cc2.code_name as curriculum_type_name,
                c.use_yn,
                c.curriculum_type_code
        }
        order by c.curriculum_name asc;

    action bulkInsertCurriculums(product_id : UUID,
                                 curriculum : many ProCurriculums) returns String;
}
