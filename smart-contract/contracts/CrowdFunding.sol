
 // SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

/// @title CrowdFunding
/// @notice Minimal on-chain crowdfunding with owner-controlled withdrawals.
contract CrowdFunding {
    uint256 public totalCollected;
    uint256 public campaignCount;

    mapping(uint256 => Campaign) public campaigns;

    struct Donation {
        address donator;
        uint256 amount;
    }

    struct Campaign {
        address owner;
        string title;
        string description;
        string imageUrl;
        uint256 target;
        uint256 collectedAmount;
        uint256 withdrawedAmount;
        uint256 deadline;
        Donation[] donations;
    }

    event CampaignCreated(
        address indexed owner,
        uint256 indexed campaignId,
        string title
    );

    event CampaignClosed(uint256 indexed campaignId);

    event DonateReceived(
        uint256 indexed campaignId,
        address indexed donator,
        uint256 amount
    );

    event Withdrawal(
        uint256 indexed campaignId,
        address indexed owner,
        uint256 amount
    );

    modifier campaignExists(uint256 campaignId) {
        require(
            campaignId < campaignCount,
            "Campaign does not exist."
        );
        _;
    }

    modifier onlyOwner(uint256 campaignId) {
        require(
            msg.sender == campaigns[campaignId].owner,
            "Only the campaign owner can do this."
        );
        _;
    }

    function createCampaign(
        string memory title,
        string memory description,
        string memory imageUrl,
        uint256 target,
        uint256 deadline
    ) external returns (uint256) {
        require(
            bytes(title).length > 0 &&
                bytes(title).length <= 100,
            "Title must be 1-100 characters."
        );

        require(
            bytes(description).length > 0 &&
                bytes(description).length <= 5000,
            "Description must be 1-5000 characters."
        );

        require(
            bytes(imageUrl).length > 0 &&
                bytes(imageUrl).length <= 2048,
            "Image URL is required."
        );

        require(
            target > 0,
            "Target must be greater than zero."
        );

        require(
            deadline > block.timestamp,
            "Deadline must be in the future."
        );

        uint256 campaignId = campaignCount;

        Campaign storage campaign = campaigns[campaignId];

        campaign.owner = msg.sender;
        campaign.title = title;
        campaign.description = description;
        campaign.imageUrl = imageUrl;
        campaign.target = target;
        campaign.deadline = deadline;

        campaignCount = campaignId + 1;

        emit CampaignCreated(msg.sender, campaignId, title);

        return campaignId;
    }

    function closeCampaign(
        uint256 campaignId
    )
        external
        campaignExists(campaignId)
        onlyOwner(campaignId)
    {
        Campaign storage campaign = campaigns[campaignId];

        require(
            campaign.deadline > block.timestamp,
            "Campaign is already closed or expired."
        );

        campaign.deadline = block.timestamp;

        emit CampaignClosed(campaignId);
    }

    function donate(
        uint256 campaignId
    ) external payable campaignExists(campaignId) {
        Campaign storage campaign = campaigns[campaignId];

        require(
            campaign.deadline > block.timestamp,
            "Campaign is closed or expired."
        );

        require(
            msg.value > 0,
            "Donation must be greater than zero."
        );

        campaign.donations.push(
            Donation(msg.sender, msg.value)
        );

        campaign.collectedAmount += msg.value;
        totalCollected += msg.value;

        emit DonateReceived(
            campaignId,
            msg.sender,
            msg.value
        );
    }

    /// @notice The owner may withdraw only the unwithdrawn balance
    /// attributed to this campaign.
    function withdraw(
        uint256 campaignId,
        uint256 amount
    )
        external
        campaignExists(campaignId)
        onlyOwner(campaignId)
    {
        Campaign storage campaign = campaigns[campaignId];

        uint256 available =
            campaign.collectedAmount - campaign.withdrawedAmount;

        require(
            amount > 0,
            "Withdrawal must be greater than zero."
        );

        require(
            amount <= available,
            "Withdrawal exceeds the available campaign balance."
        );

        // Update state before making the external call.
        campaign.withdrawedAmount += amount;

        (bool sent, ) = payable(msg.sender).call{value: amount}("");

        require(sent, "ETH transfer failed.");

        emit Withdrawal(
            campaignId,
            msg.sender,
            amount
        );
    }

    function getCampaigns()
        external
        view
        returns (Campaign[] memory)
    {
        Campaign[] memory allCampaigns =
            new Campaign[](campaignCount);

        for (uint256 i = 0; i < campaignCount; i++) {
            allCampaigns[i] = campaigns[i];
        }

        return allCampaigns;
    }

    function getDonations(
        uint256 campaignId
    )
        external
        view
        campaignExists(campaignId)
        returns (Donation[] memory)
    {
        return campaigns[campaignId].donations;
    }
}
