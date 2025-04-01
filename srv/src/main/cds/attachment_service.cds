using { com.dkbmc.demo as dm } from '../../../../db/schema';

service AttachmentService @(path: '/demo/attachment') {
    @cds.persistence.name: 'com_dkbmc_demo_attachment'
    entity Attachments as projection on dm.attachment;
}
