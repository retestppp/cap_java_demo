using {com.dkbmc.demo as dm} from '../../../../db/schema';

// 요구사항 수집 서비스
service RequirementGatherService @(path: '/requirement-gather') {
    @cds.persistence.name: 'com_dkbmc_demo_requirement_gather'
    entity RequirementGathers as projection on dm.requirement_gather;
}
