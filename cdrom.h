
#pragma once
#include <stdint.h>
#include <stdbool.h>

#define CD_CMD_GETSTAT 0x01
#define CD_CMD_TEST 0x19
#define CD_CMD_RESET 0x1C
#define CD_TEST_REGION 0x22

/**
 * Starts executing a CD command.
 *
 * @param cmd the command
 * @param params the param buffer, or NULL if length is zero
 * @param params_len parameter length in bytes
 */
void cd_command(uint_fast8_t cmd, const uint8_t * params, uint_fast8_t params_len);

/**
 * Waits for an interrupt to happen, and returns its code.
 *
 * @returns interrupt code
 */
uint_fast8_t cd_wait_int(void);

/**
 * Reads a reply from the controller after an interrupt has happened.
 *
 * @param reply reply buffer
 * @returns reply length
 */
uint_fast8_t cd_read_reply(uint8_t * reply_buffer);

/**
 * Resets the drive.
 *
 * @returns true if succeded, or false otherwise.
 */
bool cd_reset(void);
