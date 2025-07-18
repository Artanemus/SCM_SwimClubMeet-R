USE SwimClubMeet
GO


CREATE TABLE MemberLink(
    MemberID      int    NOT NULL,
    SwimClubID    int    NOT NULL,
    HouseID       int    NULL,
    CONSTRAINT PK_MemberLink PRIMARY KEY CLUSTERED (MemberID, SwimClubID), 
    CONSTRAINT FK_MemberLinkSwimClub FOREIGN KEY (SwimClubID)
    REFERENCES dbo.SwimClub(SwimClubID),
    CONSTRAINT FK_HouseMemberLink FOREIGN KEY (HouseID)
    REFERENCES dbo.House(HouseID),
    CONSTRAINT FK_MemberLink FOREIGN KEY (MemberID)
    REFERENCES dbo.Member(MemberID)
)
go



