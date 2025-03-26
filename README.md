# CaChingApp 💸

## Project Overview

CaChingApp is an innovative cash register application developed as part of a technical evaluation for an Associate Software Engineer position. The project demonstrates a practical approach to building a flexible pricing system with dynamic discount rules.

## Technical Specifications

### Tech Stack
- **Backend & Frontend:** Ruby on Rails 7.1.5.1
- **Testing Framework:** RSpec
- **Styling:** Bootstrap (integrated via CDN)

### Key Features
- Dynamic pricing rules implementation
- Flexible checkout process
- Responsive and intuitive user interface
- Comprehensive test coverage
- Easy extensibility for future enhancements

### Screenshots

#### Main Application View
![Main Application View](/docs/screenshots/main_view.jpg)
*Landing page showing available products and current promotions*

#### Empty Cart
![Empty Cart](/docs/screenshots/empty_cart.jpg)
*Cart view when no items have been added*

#### Cart with Some Products
![Cart with Some Products](/docs/screenshots/cart_with_some_products.jpg)
*Cart with products, no discounts applied*

#### Cart with Green Tea Discount
![Cart with Green Tea Discount](/docs/screenshots/cart_with_a_discount_applied_automatically.jpg)
*Cart showing the "Buy one, get one free" Green Tea discount*

#### Cart with All Discounts Applied
![Cart with All Discounts](/docs/screenshots/cart_with_all_discounts_applied.jpg)
*Cart demonstrating all available discount rules*

## Business Context

### Product Catalog
| Product Code | Name | Default Price |
|--------------|------|---------------|
| GR1 | Green Tea | 3.11€ |
| SR1 | Strawberries | 5.00€ |
| CF1 | Coffee | 11.23€ |

### Special Pricing Rules
1. **Green Tea (Buy One Get One Free)**
   - When two Green Tea products are scanned, only one is charged

2. **Strawberry Bulk Discount**
   - If 3 or more Strawberries are purchased, the price reduces to 4.50€ per unit

3. **Coffee Volume Discount**
   - When 3 or more Coffees are purchased, the price of each Coffee drops to 2/3 of the original price

### Development Context
This project represents a snapshot of my current technical skills and learning journey. It showcases:
- Practical implementation of business logic
- Test-driven development approach
- Ability to solve complex pricing scenarios
- Clean and maintainable code structure

## Test Cases Visualization

### Test Case 1: Green Tea Buy One Get One Free
![Test Case 1](/docs/screenshots/test_case_1.jpg)
*Basket: GR1, GR1*
- Expected Total: 3.11€
- Demonstrates Green Tea buy-one-get-one-free rule

### Test Case 2: Mixed Products with Strawberry Discount
![Test Case 2](/docs/screenshots/test_case_2.jpg)
*Basket: SR1, SR1, GR1, SR1*
- Expected Total: 16.61€
- Shows Strawberry bulk discount

### Test Case 3: Mixed Products with Coffee Discount
![Test Case 3](/docs/screenshots/test_case_3.jpg)
*Basket: GR1, CF1, SR1, CF1, CF1*
- Expected Total: 30.57€
- Illustrates Coffee volume discount

## Test Coverage Overview

### Model Tests

#### Cart Item Specification
Validates the `CartItem` model by:
- Ensuring correct associations with `Product` and `Cart`
- Checking validation rules for creating cart items
- Verifying that cart items require both a product and a cart
- Testing quantity handling mechanisms

#### Cart Specification
Comprehensive testing of the `Cart` model, including:
- Association validations
- Cascading deletion of cart items
- Detailed discount rule implementations
- Total price calculations across various scenarios
- Specific test cases matching original requirements
- `add_product` method functionality verification

#### Discount Rule Specification
Ensures robust validation of discount rules by:
- Validating presence of required attributes
- Checking different rule types (buy one get one free, bulk price, bulk percentage)
- Verifying value requirements for specific discount types

#### Product Specification
Validates the `Product` model's integrity through:
- Validation rules for product creation
- Uniqueness of product codes
- Price constraint checks
- Association verifications

### Controller Tests

#### Products Controller
Validates basic functionality:
- Product listing verification
- Template rendering checks

## Installation and Setup

### Prerequisites
- Ruby 3.3.5
- Rails 7.1.5.1
- Bundler
- Internet connection (for Bootstrap CDN)

### Setup Steps
```bash
# Clone the repository
git clone https://github.com/brunomoschetto/Ca-ChingApp

# Navigate to the project directory
cd Ca-ChingApp

# Install dependencies
bundle install

# Setup database
rails db:create
rails db:migrate

# Run tests
bundle exec rspec

# Start the server
rails server
```

## Running Tests

```bash
# Run all tests
bundle exec rspec

# Run specific test files
bundle exec rspec spec/models/cart_spec.rb
```

## TDD Approach

The application was developed following Test-Driven Development (TDD) methodology:
- Tests were written before implementing features
- Each feature was developed in a separate branch
- Commits were kept small and focused
- Comprehensive test coverage ensures code reliability

## Potential Improvements
- Implement user authentication
- Add more complex discount strategies
- Create an admin interface for product management
- Expand error handling
- Implement persistent cart storage

## Contributing
1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Contact
Bruno Moschetto
[LinkedIn Profile](https://www.linkedin.com/in/bruno-moschetto/)
