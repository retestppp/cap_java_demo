using {com.dkbmc.demo as dm} from '../../../../db/schema';

service commonCode @(path: '/common-code') {
    entity commonCode as projection on dm.common_code
                         order by
                             group_code_cd asc,
                             sort_order asc;

    action bulkInsert(commonCodes : many commonCode); // 액션 등록
}
