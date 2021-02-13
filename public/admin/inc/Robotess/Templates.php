<?php
declare(strict_types=1);

namespace Robotess;

/**
 * Class Templates
 * @package Robotess
 */
final class Templates
{
    public string $stats = '<p class="details">
<strong>Members:</strong> {members} (<em>{pending} Pending </em>)<br>
<strong>Since:</strong> {since}<br>
<strong>Last Updated:</strong> {updated}
<strong>Script used:</strong> <a href="https://scripts.robotess.net">Listing Admin [Robotess Fork]</a> (originally by Tess)
</p>';
    public string $affiliates = '<a href="{url}"><img src="{image}" alt="{subject}" title="{subject}" /></a>';
    public string $wishlist = '';
    public string $members = '<li>{name}<br />
{email} &middot; {url}</li>';
    public string $members_header = '<ol>';
    public string $members_footer = '</ol>';
    public string $updates = '<div class="entry_listingadmin">
<span class="date">{date}</span> {entry}
<p class="tc cat">Filed Under: {categories}</p>
</div>';
}