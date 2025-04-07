@isTest
public class RewardsCalloutServiceTest {
    @isTest 
    static void testSubmitUsersForRewardCallout() {
        Test.setMock(HttpCalloutMock.class, new RewardsCalloutServiceMock());

        List<Wellness_Journey__c> lJourneys = new List<Wellness_Journey__c>();

        User user = [SELECT Id, Name, Username, Email FROM User WHERE Id = :UserInfo.getUserId()];
        
        for (Integer i = 0; i < 12; i++) {
            lJourneys.add(new Wellness_Journey__c(
                OwnerId = user.Id
            ));
        }

        insert lJourneys;

        Test.startTest();
            Database.executeBatch(new WellnessJourneyRewardsBatch());
        Test.stopTest();

        // Assertions to validate the behavior can be added here
        Integer statusCode = RewardsCalloutService.submitUsersForRewardCallout(JSON.serialize(lJourneys));

        Assert.areEqual(200, statusCode, 'O código do status HTTP deveria ser 200');
    }
}