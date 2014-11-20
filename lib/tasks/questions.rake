namespace :questions do
 desc "Initialise Qs"
 task create: :environment do

Question.create(number: "00010", question: "Question: Relationship") unless Question.find_by(number: "00010") 

Question.create(number: "00020", question: "Question: *First name") unless Question.find_by(number: "00020") 

Question.create(number: "00030", question: "Question: *Middle name(s)") unless Question.find_by(number: "00030") 

Question.create(number: "00040", question: "Question: *Surname") unless Question.find_by(number: "00040") 

Question.create(number: "00050", question: "Question: Postcode") unless Question.find_by(number: "00050") 

Question.create(number: "00060", question: "Question: *Flat or house name/number") unless Question.find_by(number: "00060") 

Question.create(number: "00070", question: "Question: *Street") unless Question.find_by(number: "00070") 

Question.create(number: "00080", question: "Question: *City") unless Question.find_by(number: "00080") 

Question.create(number: "00090", question: "Question: County") unless Question.find_by(number: "00090") 

Question.create(number: "00100", question: "Question: Country") unless Question.find_by(number: "00100") 

Question.create(number: "00110", question: "Question: Land Registry title number (if known)") unless Question.find_by(number: "00110") 

Question.create(number: "00120", question: "Question: Postcode") unless Question.find_by(number: "00120") 

Question.create(number: "00130", question: "Question: *Flat or house name/number") unless Question.find_by(number: "00130") 

Question.create(number: "00140", question: "Question: *Street") unless Question.find_by(number: "00140") 

Question.create(number: "00150", question: "Question: *City") unless Question.find_by(number: "00150") 

Question.create(number: "00160", question: "Question: County") unless Question.find_by(number: "00160") 

Question.create(number: "00170", question: "Question: Country") unless Question.find_by(number: "00170") 

Question.create(number: "00180", question: "Question: Charity name") unless Question.find_by(number: "00180") 

Question.create(number: "00190", question: "Question: Registered charity number") unless Question.find_by(number: "00190") 

Question.create(number: "00200", question: "Question: Postcode") unless Question.find_by(number: "00200") 

Question.create(number: "00210", question: "Question: *Flat or house name/number") unless Question.find_by(number: "00210") 

Question.create(number: "00220", question: "Question: *Street") unless Question.find_by(number: "00220") 

Question.create(number: "00230", question: "Question: *City") unless Question.find_by(number: "00230") 

Question.create(number: "00240", question: "Question: County") unless Question.find_by(number: "00240") 

Question.create(number: "00250", question: "Question: Country") unless Question.find_by(number: "00250") 

Question.create(number: "01010", question: "1A.1 Question: Please tick this box if you consent to us providing you in future with information relating to additional services we offer and important changes to the law") unless Question.find_by(number: "01010")

Question.create(number: "01020", question: "1A.2 Question: Contact telephone number") unless Question.find_by(number: "01020") 

Question.create(number: "01030", question: "1A.3 Question: Gender") unless Question.find_by(number: "01030") 

Question.create(number: "01040", question: "1A.4 Question: Date of birth") unless Question.find_by(number: "01040") 

Question.create(number: "01050", question: "1A.5 Question: What country do you consider to be your domicile?") unless Question.find_by(number: "01050") 

Question.create(number: "01060", question: "1A.6 Question: *Do you have children?") unless Question.find_by(number: "01060") 

Question.create(number: "01070", question: "1A.7 Question: *Are any of your children under the age of 18?") unless Question.find_by(number: "01070") 

Question.create(number: "01080", question: "1A.9 Question: *Are you planning to marry or form a civil partnership in the near future?") unless Question.find_by(number: "01080") 

Question.create(number: "01090", question: "1A.10 Question: Do you want this will to be effective after the marriage or civil partnership?") unless Question.find_by(number: "01090") 

Question.create(number: "01110", question: "1A.11 Question: Would you like this will to take effect even if you have not married or entered into the civil partnership at the date of your death?") unless Question.find_by(number: "01110") 

Question.create(number: "01120", question: "1A.13 Question: Will the recipients of gifts under your will be responsible for any taxes such as inheritance tax or capital gains tax on the transfer?") unless Question.find_by(number: "01120") 

Question.create(number: "01130", question: "1A.14 Question: If you have a partner, does that person want an identical \"mirror\" will?") unless Question.find_by(number: "01130") 

Question.create(number: "01140", question: "1B.1 Question: Contact telephone number") unless Question.find_by(number: "01140") 

Question.create(number: "01150", question: "1B.2 Question: Gender") unless Question.find_by(number: "01150") 

Question.create(number: "01160", question: "1B.3 Question: Date of birth") unless Question.find_by(number: "01160") 

Question.create(number: "01170", question: "1B.4 Question: What country does your partner consider to be their domicile?") unless Question.find_by(number: "01170") 

Question.create(number: "02010", question: "2.1 Question: *Funeral preferences") unless Question.find_by(number: "02010") 

Question.create(number: "02020", question: "2.2 Question: My funeral wishes are that I would like to...") unless Question.find_by(number: "02020") 

Question.create(number: "02030", question: "2.3 Question: Would you like to donate organs?") unless Question.find_by(number: "02030") 

Question.create(number: "02040", question: "2.4 Question: The organs I would like to donate are my...") unless Question.find_by(number: "02040") 

Question.create(number: "03010", question: "3A.1 Question: *Would you like to appoint Notary Express as a professional executor?") unless Question.find_by(number: "03010") 

Question.create(number: "03020", question: "3A.2 Question: *Would you like to appoint an executor?") unless Question.find_by(number: "03020") 

Question.create(number: "03030", question: "3A.3 Question: Appoint a 2nd executor?") unless Question.find_by(number: "03030") 

Question.create(number: "03040", question: "3A.4 Question: Appoint a 3rd executor?") unless Question.find_by(number: "03040") 

Question.create(number: "03050", question: "3A.5 Question: Appoint a 4th executor?") unless Question.find_by(number: "03050") 

Question.create(number: "03060", question: "3B.1 Question: *Would you like to appoint a replacement executor?") unless Question.find_by(number: "03060") 

Question.create(number: "03070", question: "3B.2 Question: Appoint a 2nd replacement executor?") unless Question.find_by(number: "03070") 

Question.create(number: "03080", question: "3B.3 Question: Appoint a 3rd replacement executor?") unless Question.find_by(number: "03080") 

Question.create(number: "03090", question: "3B.4Question: Appoint a 4th replacement executor?") unless Question.find_by(number: "03090") 

Question.create(number: "04010", question: "4.1 Question: I accept the additional administration powers advised by Notary Express") unless Question.find_by(number: "04010") 

Question.create(number: "04020", question: "4.2 Question: I want to give the administrators of my estate expanded powers to deal with my assets subject to complying with the terms of my will") unless Question.find_by(number: "04020") 

Question.create(number: "04030", question: "4.3 Question: I want to give the administrators of my estate express powers to borrow, charge, lend, guarantee, give security and buy or improve trust property") unless Question.find_by(number: "04030") 

Question.create(number: "04040", question: "4.4 Question: I want to give the administrators of my estate express powers to appoint other administrators and/or delegate tasks if they feel it to be necessary") unless Question.find_by(number: "04040")

Question.create(number: "04050", question: "4.5 Question: I want to give the administrators and connected individuals express powers to be able to buy and sell trust fund assets on their own behalf in certain circumstances") unless Question.find_by(number: "04050")

Question.create(number: "04060", question: "4.6 Question: I want to give the administrators of my estate express protection from liability for acts other than deliberate recklessness or fraud") unless Question.find_by(number: "04060") 

Question.create(number: "05010", question: "5A.1 Question: Would you like to appoint guardians for any future children under the age of 18 that you may have?") unless Question.find_by(number: "05010") 

Question.create(number: "05020", question: "5A.2 Question: Would you like to appoint a guardian for your children under the age of 18?") unless Question.find_by(number: "05020") 

Question.create(number: "05030", question: "5A.3 Question: Appoint a 2nd guardian?") unless Question.find_by(number: "05030") 

Question.create(number: "05040", question: "5A.4 Question: Appoint a 3rd guardian?") unless Question.find_by(number: "05040") 

Question.create(number: "05050", question: "5A.5 Question: Appoint a 4th guardian?") unless Question.find_by(number: "05050") 

Question.create(number: "05060", question: "5B.1 Question: Would you like to appoint a replacement guardian?") unless Question.find_by(number: "05060") 

Question.create(number: "05070", question: "5B.2 Question: Appoint a 2nd replacement guardian?") unless Question.find_by(number: "05070") 

Question.create(number: "05080", question: "5B.3 Question: Appoint a 3rd replacement guardian?") unless Question.find_by(number: "05080") 

Question.create(number: "05090", question: "5B.4 Question: Appoint a 4th replacement guardian?") unless Question.find_by(number: "05090") 

Question.create(number: "06010", question: "6.1 Question: Add a cash gift?") unless Question.find_by(number: "06010") 

Question.create(number: "06020", question: "6.2 Question: Is this a gift to be shared between all of your children or all of your grandchildren?") unless Question.find_by(number: "06020") 

Question.create(number: "06030", question: "6.3 Question: Cash gift amount (£)") unless Question.find_by(number: "06030") 

Question.create(number: "06040", question: "6.4 Question: To be paid only when the recipient reaches a certain age?") unless Question.find_by(number: "06040") 

Question.create(number: "06050", question: "6.5 Question: If the recipient fails to survive you, their share should be...") unless Question.find_by(number: "06050") 

Question.create(number: "06060", question: "6.6 Question: To be paid only when the child(ren) reach(es) a certain age?") unless Question.find_by(number: "06060") 

Question.create(number: "06070", question: "6.7 Question: Add a 2nd cash gift?") unless Question.find_by(number: "06070") 

Question.create(number: "07010", question: "7.1 Question: Add a donation to charity?") unless Question.find_by(number: "07010") 

Question.create(number: "07020", question: "7.2 Question: Select from a list of popular charities?") unless Question.find_by(number: "07020") 

Question.create(number: "07030", question: "7.3 Question: Select charity...") unless Question.find_by(number: "07030") 

Question.create(number: "07040", question: "7.4 Question: Charitable gift amount (£)") unless Question.find_by(number: "07040") 

Question.create(number: "07050", question: "7.5 Question: (optional) I request that the charity use this gift towards...") unless Question.find_by(number: "07050") 

Question.create(number: "07060", question: "7.6 Question: Add a 2nd donation to charity?") unless Question.find_by(number: "07060") 

Question.create(number: "07070", question: "7.7 Question: Tick to permit your executors to choose an alternative charity if the one(s) you selected do not exist for any reason at the date of your death (advisable)") unless Question.find_by(number: "07070") 

Question.create(number: "08010", question: "8.1 Question: Would you life to make a specific gift of a building or land?") unless Question.find_by(number: "08010") 

Question.create(number: "08020", question: "8.2 Question: Is this a gift of your sole or main residence?") unless Question.find_by(number: "08020") 

Question.create(number: "08030", question: "8.3 Question: Number of recipients for the gift of property") unless Question.find_by(number: "08030") 

Question.create(number: "08040", question: "8.4 Question: Should the recipients hold the property as joint tenants or tenants in common?") unless Question.find_by(number: "08040") 

Question.create(number: "08050", question: "8.5 Question: Should the recipients be responsible for any charges secured on the property?") unless Question.find_by(number: "08050") 

Question.create(number: "08060", question: "8.7 Question: If the property has been sold at the date of your death, would you like this gift to take the form of a gift of the sale proceeds?") unless Question.find_by(number: "08060") 

Question.create(number: "08070", question: "8.8 Question: Is the property to be held on trust for the life of one or more individuals?") unless Question.find_by(number: "08070") 

Question.create(number: "08080", question: "8.9 Question: Number of life beneficiaries") unless Question.find_by(number: "08080") 

Question.create(number: "08090", question: "8.10 Question: Would you life to make a specific gift of a 2nd building or land?") unless Question.find_by(number: "08090") 

Question.create(number: "09010", question: "9.1 Question: Add a personal gift?") unless Question.find_by(number: "09010") 

Question.create(number: "09020", question: "9.2 Question: Describe the gift in as much detail as possible - I give my...") unless Question.find_by(number: "09020") 

Question.create(number: "09030", question: "9.3 Question: If any personal gift has been sold at the date of your death, would you like the gift to take the form of a gift of the sale proceeds?") unless Question.find_by(number: "09030") 

Question.create(number: "09040", question: "9.4 Question: Add a 2nd personal gift?") unless Question.find_by(number: "09040") 

Question.create(number: "10010", question: "10A.1 Question: Add a beneficiary?") unless Question.find_by(number: "10010") 

Question.create(number: "10020", question: "10A.2 Question: Share of the residuary") unless Question.find_by(number: "10020") 

Question.create(number: "10030", question: "10A.3 Question: Should the gift be held till the beneficiary reaches a certain age?") unless Question.find_by(number: "10030") 

Question.create(number: "10040", question: "10A.4 Question: If this beneficiary fails to survive you, their share should be...") unless Question.find_by(number: "10040") 

Question.create(number: "10050", question: "10A.5 Question: If the gift goes to their child should it be held till the child reaches a certain age?") unless Question.find_by(number: "10050") 

Question.create(number: "10060", question: "10A.6 Question: Add a 2nd beneficiary?") unless Question.find_by(number: "10060") 

Question.create(number: "10070", question: "10A.7 Question: If your executors hold assets on trust because a beneficiary has not yet reached the age you specified for inheritance, how much of the capital would you like them to be able to apply for the benefit of that beneficiary?") unless Question.find_by(number: "10070") 

Question.create(number: "10080", question: "10B.1 Question: Add a secondary beneficiary?") unless Question.find_by(number: "10080") 

Question.create(number: "10090", question: "10B.2 Question: Share of the residuary if the gift to your primary beneficiaries does not take effect") unless Question.find_by(number: "10090") 

Question.create(number: "10100", question: "10B.3 Question: Should the gift be held till the secondary beneficiary reaches a certain age?") unless Question.find_by(number: "10100") 

Question.create(number: "10110", question: "10B.4 Question: If this secondary beneficiary fails to survive you, their share should be...") unless Question.find_by(number: "10110") 

Question.create(number: "10120", question: "10B.5 Question: If the gift goes to their child should it be held till the child reaches a certain age?") unless Question.find_by(number: "10120") 

Question.create(number: "10130", question: "10B.6 Question: Add a 2nd secondary beneficiary?") unless Question.find_by(number: "10130") 

Question.create(number: "11010", question: "11.1 Question: Do you want to make any specific, non-binding requests?") unless Question.find_by(number: "11010") 

Question.create(number: "11020", question: "11.2 Question: I make the following requests concerning the bequests made under my will...") unless Question.find_by(number: "11020") 
end
end
