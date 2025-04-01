using {com.dkbmc.demo as dm} from '../../../../db/schema';

service MediaService @(path: '/media') {
    @cds.persistence.name: 'com_dkbmc_demo_media'
    entity Media   as projection on dm.media ;

    // action submit();

    type loginInfo : {
        id: String;
        title: String;
        name: String;
    };

    action loginAction(JSON : loginInfo);
}


