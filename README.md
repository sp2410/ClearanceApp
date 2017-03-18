# Problem

We need to clearance inventory from time to time.  Certain items don't sell through to our vendors, so every month, we collect certain unsold items and sell them to a third party vendor for a portion of their wholesale price.

# Vocabulary

_Items_ refer to individual pieces of clothing.  So, if we have two of the exact same type of jeans, we have two items.  Items are grouped by _style_, so
the two aforementioned items would have the same style.

Important data about an item is:

* size
* color
* status - sellable, not sellable, sold, clearanced
* price sold
* date sold

A style's important data is:

* wholesale price
* retail price
* type - pants, shirts, dresses, skirts, other
* name

The _users_ of this application are warehouse employees (not developers).  
They have a solid understanding the business process they must carry out and look to our software to support them.

# Requirements

This application currently handles the clearance task in a very basic way. A spreadsheet containing a list of item ids is uploaded and those items are clearanced as a batch. Items can only be sold at clearance if their status is 'sellable'. When the item is clearanced, we sell it at 75% of the wholesale price, and record that as "price sold".


- The vendor buying the items on clearance needs to know what they've just purchased, so please provide a report for each batch about what items were clearanced.
- We'd like to avoid requiring that users create a spreadsheet and upload it, and instead handle this process directly in the app.  Since they can scan an item's barcode into any text field (as if typed directly by a keyboard), we'd like to try allowing them to create batches and clearancing them simply by entering item IDs.
# Tech Specs:

- Rails 4.2
- Ruby 2.2
- SQLite preferred, Postgres OK

