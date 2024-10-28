# Stripe Checkout

Stripe Checkout is a web application that integrates with Stripe to handle subscription payments. It provides a seamless checkout experience for users and includes email notifications for successful transactions.

## Setup

### Environment Variables

Ensure you have the necessary environment variables set up. Specifically, you need to fill in the `STRIPE_API_TOKEN` in the `.env.development` file:

```
STRIPE_API_TOKEN=your_stripe_api_token
```

## Starting the Application

### Docker Compose

To start the application using Docker Compose, follow these steps:

Build and start the containers:

```
docker-compose --env-file .env.development up
```

The application will be available at http://localhost:3000.

### First steps

After open the app, please click **Refresh Bundles** button at the top of the dashboard - this will download all bundles to buy from Stripe account

After buying specific plan, you can access mailhog ([http://locahost:8025](http://localhost:8025)) to accesss incoming mails after successful purchase.
