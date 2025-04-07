@isTest
public class WellnessJourneyRewardsBatchTest {
    @testSetup
    static void setup() {
        User user = new User(
            FirstName = 'Test',
            LastName = 'User1',
            Email = 'user1@example.com',
            Username = 'user1qweqweqwe@example.com',
            Alias = 'tuser1',
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            ProfileId = [SELECT Id FROM Profile WHERE Name IN ('Standard User', 'Usuário Padrão') LIMIT 1].Id
        );
        insert user;

        List<Wellness_Journey__c> lJourneys = new List<Wellness_Journey__c>();
        for (Integer i = 0; i < 13; i++) {
            lJourneys.add(new Wellness_Journey__c(
                Name = 'Journey ' + i,
                OwnerId = user.Id,
                Status__c = 'Complete',
                Completion_Date__c = Date.today().addDays(-90)
            ));
        }

        insert lJourneys;
    }

    @isTest
    static void testWellnessJourneyRewardsBatch() {
        Test.setMock(HttpCalloutMock.class, new RewardsCalloutServiceMock());

        Test.startTest();
            WellnessJourneyRewardsBatch batch = new WellnessJourneyRewardsBatch();
            Database.executeBatch(batch);
        Test.stopTest();

        List<Wellness_Journey__c> lWellnessJourneys = [SELECT Id FROM Wellness_Journey__c WHERE Status__c = 'Complete'];
        Assert.areEqual(13, lWellnessJourneys.size(), 'A lista lWellnessJourneys deveria ter 13 elementos');
    }

}