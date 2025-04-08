@isTest
public with sharing class AccessibilityProjectBillingTest {
    @isTest
    static void testCallBillingService() {
        Test.setMock(WebServiceMock.class, new BillingCalloutServiceMock());

        Accessibility_Project__c accessibilityproject = new Accessibility_Project__c();
        accessibilityproject.Amount__c = 120.00;
        insert accessibilityproject;

        Test.startTest();
        
            AccessibilityProjectBilling.callBillingService(accessibilityproject.Id, accessibilityproject.Amount__c);

        Test.stopTest();
        
        accessibilityproject = [SELECT Status__c FROM Accessibility_Project__c WHERE Id = :accessibilityproject.Id];

        Assert.areEqual('Complete', accessibilityproject.Status__c, 'O status do projeto deveria ser "Complete"');
    }
}