using {com.dkbmc.demo as dm} from '../db/schema';

service MediaService @(path: '/media') {
    entity Media   as projection on dm.media ;

    // action submit();

    type loginInfo : {
        id: String;
        title: String;
        name: String;
    };

    action loginAction(JSON : loginInfo);
}


