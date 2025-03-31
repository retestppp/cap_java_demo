using {com.dkbmc.demo as dm} from '../db/schema';

service AttachmentService  @(path: '/demo/attachment') {
    entity Attachment as projection on dm.attachment;
}

